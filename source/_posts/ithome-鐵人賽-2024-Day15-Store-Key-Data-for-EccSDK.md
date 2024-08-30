---
title: ithome 鐵人賽-2024-Day15 Store Key Data for EccSDK
author: James Hsueh
date: 2024-08-22 01:05:50
tags: "ithome 鐵人賽-2024"
categories: "ithome 鐵人賽-2024"
---
Hi all, 來到第15天，今天就來好好處理如何永久儲存 變色龍雜湊函數所需要使用的 key 吧
<!--more-->
不多說直接呈現 code吧

- 首先我們需要更動 DI 的部分，我們抽一個 KeyStorageService 來做 Key 載入/存放 這件事情。

```csharp
var keyStorageService = new KeyStorageService();
var keyData = keyStorageService.LoadKeyPair();

builder.Services.AddSingleton(keyData.KeyPair);
builder.Services.AddSingleton(keyData.SessionKey);
```

- 接著我們就可以來實作 KeyStorageService，code如下

```csharp
public class KeyStorageService
{
    private const string KeysPath = "~/keys.json";

    public KeyData LoadKeyPair()
    {
        if (File.Exists(KeysPath))
        {
            return RestoreKeys(KeysPath);
        }

        var keyData = new KeyData()
        {
            KeyPair = EccGenerator.GenerateKeyPair(256),
            SessionKey = SessionKeyGenerator.GenerateSessionKey()
        };
        keyData.SaveKeys(KeysPath);
        return keyData;
    }

    private KeyData RestoreKeys(string path)
    {
        var keyData = File.ReadAllText(path);
        return JsonSerializer.Deserialize<KeyData>(keyData)!;
    }
}
```

其中，我們使用了些檔案讀寫的方式來做存放，主要流程為:

1. 檢查key 是否存在
2. 若存在，直接做 KeyRestore 的作業
3. 若不存在，直接新增 key pair 及 session key
4. 最後將 session key 及 key pair 多墊一層 KeyData 的 model 進行回傳

## Conlusion

今天我們定義好了 key 要怎麼進行存放，且針對有無已存在key file 進行處理。 好了今天先到這。