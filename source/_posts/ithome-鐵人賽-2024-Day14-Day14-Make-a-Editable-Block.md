---
title: ithome 鐵人賽-2024-Day14 Make a Editable Block
author: James Hsueh
date: 2024-08-22 00:04:37
tags: "ithome 鐵人賽-2024"
categories: "ithome 鐵人賽-2024"
---
Hi all 來到14天， 昨天我們成功把專案引入EccSDK，同時也將 insert 區塊的變色龍雜湊值補上，但似乎還少了點啥，今天就來定義下吧。
<!--more-->

由於目前的區塊雜湊值是這樣組成 ( 如 code)

```csharp
HashHelper.ToSha256($"{dto.TimeStamp}:{Hash}:{dto.Data}:{nonce}"),
```

我們需要將其點小調整，如下

```csharp
HashHelper.ToSha256($"{dto.TimeStamp}:{Hash}:{dto.Data}:{nonce}:{ChameleonHash}"),
```

我們將變色龍雜湊值加入計算 hash 的要件之一。然而在計算變色龍雜湊前，還需要再定義下 Hash Message 的組成，以下是我目前的做法

```csharp
    public BlockDomain GenerateNextBlock(GenerateNewBlockDto dto, int nonce)
    {
        var message = $"{dto.TimeStamp}:{Hash}:{nonce}";
        var chameleonHash = ChameleonHashHelper.GetChameleonHash(new ChameleonHashRequest()
        {
            KeyPair =dto.KeyPair ,
            Message = Data 
        });
        
        return new BlockDomain
        {
            Data = dto.Data,
            PreviousHash = Hash,
            TimeStamp = dto.TimeStamp,
            Hash = HashHelper.ToSha256($"{message}:{chameleonHash}"),
            Nonce = nonce,
            ChameleonSignature = ChameleonHashHelper.Sign(new ChameleonHashRequest
            {
                KeyPair = dto.KeyPair,
                Message = message,
                SessionKey = dto.SessionKey.Key,
                Order = dto.KeyPair.PublicKey.Curve.Order,
            }),
        };
    }

```

經過以上的小調正，我們如果要做message 編輯的話，只需要重新做變色龍雜湊值的計算即可。

由於我們把 message的要素放進 變色龍雜湊的運算，因此只要keypair 維持在同一把的情況下，區塊的雜湊值將不會做變化，但 Data 可以。

好啦，今天先到這邊惹，開心星期五值得開心。