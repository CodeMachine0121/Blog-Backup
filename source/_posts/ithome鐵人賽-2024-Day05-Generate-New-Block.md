---
title: ithome鐵人賽-2024 Day05 Generate New Block
tags: "ithome 鐵人賽-2024"
abbrlink: c1987c23
date: 2024-08-11 23:18:01
---
Hi all, 來到第五天，今天目標是是解說下 區塊的產生並將其實做出來。

首先我們的區塊組成如昨天所述:

```json
{
  "Id": 0,
  "Data": "string",
  "Hash": "string",
  "PreviousHash": "string",
  "TimeStamp": DateTime,
  "Nonce": 0
}
```



其中 Nonce 是每次計算雜湊值時為了讓雜湊值符合計算難易度所需要的亂數。

由於這是個測試用的區塊鏈，所以我們不會考慮到難易度的問題，但為求往後的需要我們還是保留這個參數。

另外，我們還會遇到一個問題，那就是計算 sha256 的雜湊值。

由於他會是個類似於工具的一個類別層級，因此我這邊先將其計算的 method 抽至 `HashHelper` 這個 Helper 物件中，code 如下:

```csharp
public static class HashHelper
{
    public static string ToSha256(string data)
    {
        var sha256Hash = SHA256.Create();
        var builder = new StringBuilder();
        
        var bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(data));
        foreach (var t in bytes)
        {
            builder.Append(t.ToString("x2"));
        }
        return builder.ToString();
    } 
}
```

那我們來列一下今天 coding 部分的驗收條件

1. 透過 API 產生新區塊
2. 該區塊是由上一個區塊的雜湊值產生
3. 透過 API 取得整條鏈的情況

以下是 TDD 開發的過程，供參

[![Yes](https://img.youtube.com/vi/-wfHTxRAuuU/0.jpg)](https://www.youtube.com/watch?v=-wfHTxRAuuU)

經由影片中，可以發現其實我們的 service 是有瑕疵的，因為在 Service 層我們 hard code 去拿 **id=0** 的 Block。以正常的邏輯來說，我們應該去拿取目前鏈上最後一個區塊，但由於目前還沒有定義好我們的區塊鏈該存放在哪，因此 Repository 層也沒有所謂的 BlockChain 可以索取資料。

關於 Repository 怎麼跟 BlockChain 的取得最後筆資料來產生下個區塊的雜湊值，目前我打算讓 Repository向資料庫索取，但~~~那是明天的事情了哈。

PS. 暫時解其實可以在 Repository 層定義一個 Field List of Block 來當作區塊鏈物件做使用，但此次專案的scope 是要將 BlockChain 放到資料庫存放，所以就先沒有這樣做。

付上[專案 GitHub 任意門](https://github.com/CodeMachine0121/CustomBlockChainLab.git)~~~

結語:  不小心開賽，導致每天鐵人賽都是 Free  Style…
