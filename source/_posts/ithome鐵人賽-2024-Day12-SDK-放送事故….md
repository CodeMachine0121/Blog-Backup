---
title: ithome鐵人賽-2024-Day12-SDK 放送事故…
tags: "ithome 鐵人賽-2024"
abbrlink: '78964999'
date: 2024-08-14 23:23:37
---

各位... 由於 SDK 的放送事故，今天就來搶修下 我們的 EccSDK

主要問題: BigInteger Reference 衝突

- 由於在專案中產生 Session Key 時，其型別為 BigInteger，但發現這個型別 Reference 的地方竟然有兩個 = =

Solution:

- 把 SessionKey 封裝起來，讓使用端透過 SessionKeyHelper 產生，code 如下



```csharp
public class SessionKeyGenerator
{
    public static BigInteger GenerateSessionKey()
    {
        return new BigInteger(256, new Random());
    }
}
```

以上是暫時解法，今天就先這樣了~~~ 需要好好來想想怎麼會有 Reference 衝突的問題@@

結語: 刺激星期三，明天不是假日，後天也不是
