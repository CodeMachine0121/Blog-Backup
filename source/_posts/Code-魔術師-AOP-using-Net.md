---
title: Code 魔術師 - AOP using Fody
abbrlink: b8160fb4
date: 2024-12-07 19:50:36
tags:
---

Hi all, 因為工作上的關係接觸到了所謂的 AOP 框架, 覺得挺有趣的故藉此文章分享。

## Introduce
AOP(面向方面程式設計/Aspect-Oriented Programming), 他是一種寫程式的方法，簡單來說就是把一些常常要用到,但是跟主要業務邏輯無關的功能抽出來統一處理。
舉個例子， 假設我們在寫一個購物網站然後建立交易的流程如下：
<!--more-->
```
public void 購物流程() {
    寫入Log("開始購物");  
    檢查會員登入();      
    計算處理時間開始(); // for Tracing 
    
    // 真正的購物邏輯
    檢查商品庫存();
    建立訂單();
    扣除庫存();
    
    計算處理時間結束(); // for Tracing
    寫入Log("購物完成");
}
```
看完之後會發現，實際上處理購物的邏輯只有中間那三行，但是我們前前後後要加一堆其他的東西 (Log, 登入, 計時等)。如果每個功能都要這樣寫,程式碼就會變得很亂,而且重複的程式碼到處都是。
這時候就可以用AOP的想法來處理，我們把跟購物無關的東西抽出來，流程如下：
```
@需要登入
@要記錄Log
@計算執行時間
public void 購物流程() {
    // 只要寫真正要做的事就好
    檢查商品庫存();
    建立訂單();
    扣除庫存();
}
```
看出來了嗎？ 這個是不是很像後端API的ActionFilter 或是 Middleware的概念，但其實概念差不多只是再應用場景有些許的不同
| 比較特性 | 執行時機 | 作用範圍 | 使用場景 |
|---------|---------|---------|----------|
| Middleware | HTTP Request Pipeline 最早期 | 整個 Application | 身分驗證, 請求加解密, CORS 處理, 異常處理 |
| Action Filter | Controller/Action 執行前後 | 限於 Controllers | Model 驗證, Action 權限檢查, 回應格式處理 |
| AOP | 任何方法執行時期 | 任何類別或方法 | 方法層級快取, 效能監控, 交易管理, 記錄日誌 |

## 個人使用場景
我自己的使用場景，是要為了做一個替專案進行可觀側性監控的SDK，但不希望再改到使用端的code 的限制下進行設計。
那此次的SDK 撰寫是使用 [Fody](https://github.com/Fody/Fody) 作為AOP框架提供，以下是基本的應用範例。

## Demo Project
### Startup Main Project | Part I
- 目的：在呼叫專案內任何method 前必須執行一特定method

以下是我們的 API main flow code 
```csharp=
[Route("api/[controller]")]
public class DemoController(IDemoService demoService) : ControllerBase
{
    [HttpGet]
    public IActionResult Get()
    {
        demoService.Echo();
        return Ok("Hello World");
    }
}

public class DemoService(IDemoRepository demoRepository) : IDemoService
{
    public void Echo()
    {
        demoRepository.Echo();
    }
}

public class DemoRepository : IDemoRepository
{
    public void Echo()
    {
        throw new NotImplementedException();
    }
}
```
### Startup AOP

接著我們就可以安裝以下 nuget 套件：
- Fody $\rightarrow$ 專案本體
- FodyHelper $\rightarrow$ Library 專案

首先，我們必須建立一個專案，名字暫定叫做 `AOP-Library.Fody`，這邊要記住由於 Fody 的特性，這裡的專案名必須要有`.Fody` 作為後綴詞（理論上有另一種不需要多添加後綴詞的解法，礙於篇幅就先不敘述），接著來撰寫要讓AOP做的事情，code如下：

#### MethodLogger
此為，攔截 method
```chsharp
public static class MethodLogger
{
    public static void Log(string methodName)
    {
        Console.WriteLine($"Interceptor get: {methodName}");
    }
}
```
#### ModuleWeaver
在這邊進行 IL code 注入，達到攔截效果
```csharp
public class ModuleWeaver : BaseModuleWeaver
{
    public override void Execute()
    {
        var logMethod = typeof(MethodLogger).GetMethod(nameof(MethodLogger.Log));
        var logMethodRef = ModuleDefinition.ImportReference(logMethod);

        foreach (var type in ModuleDefinition.Types)
        {
            if (ShouldProcessType(type))
            {
                foreach (var method in type.Methods)
                {
                    if (ShouldProcessMethod(method))
                    {
                        var il = method.Body.GetILProcessor();
                        method.Body.InitLocals = true;

                        var first = method.Body.Instructions.First();

                        var loadMethodName = il.Create(OpCodes.Ldstr, method.FullName);

                        var callLog = il.Create(OpCodes.Call, logMethodRef);

                        il.InsertBefore(first, loadMethodName);
                        il.InsertAfter(loadMethodName, callLog);

                        method.Body.Optimize();
                    }
                }
            }

        }
    }

    public override IEnumerable<string> GetAssembliesForScanning()
    {
        yield return "netstandard";
        yield return "mscorlib";
        yield return "System.Runtime";
        yield return "System.Console";
    }

    private bool ShouldProcessType(TypeDefinition type)
    {
        // 跳過系統類型、介面和特殊類型
        return !type.IsInterface &&
               !type.IsEnum &&
               !type.IsAbstract &&
               !type.IsValueType &&
               !type.FullName.StartsWith("System.") &&
               !type.FullName.StartsWith("<");

    }

    private bool ShouldProcessMethod(MethodDefinition method)
    {
        return method.HasBody &&
               !method.IsConstructor &&
               !method.IsGetter &&
               !method.IsSetter &&
               !method.IsAbstract &&
               !method.IsRuntime &&
               !method.IsPInvokeImpl;
    }
}
```

### Startup Main Project | Part II

設定好上述的AOP注入後，我們還需要來 Main Project這邊針對 csproj 做些事情，如下：
#### Csproj
```
<Project>
    ...
    <ItemGroup>
        <ProjectReference Include="..\AOP-Library.Fody\AOP-Library.Fody.csproj" />
        <WeaverFiles Include="$(OutputPath)AOP-Library.Fody.dll"/>
    </ItemGroup>
</Project>
```

### Run Project
在這邊就可以嘗試把專案跑起來看看，如果一切順利的話，Console畫面會跟下圖一樣。

![img.png](/images/AOP.png)

## Conclusion
以上就是使用 Fody 作為AOP框架的應用實作，但其實AOP 還有另一個框架工具：`Castle.Core`，那兩者雖然都是AOP框架，但使用上的方式截然不同，若有空的話我再來寫一篇 `Castle.Core`的應用實作，今天先到這。




