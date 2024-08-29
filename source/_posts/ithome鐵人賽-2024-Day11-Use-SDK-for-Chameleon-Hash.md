---
title: ithome鐵人賽-2024-Day11-Use SDK for Chameleon Hash
tags: "ithome 鐵人賽-2024"
abbrlink: 5edf55db
date: 2024-08-13 21:46:24
---
Hi all, 來到第 11 天，今天就來講講該如何把昨天的公式實作吧。

首先這次會使用到的物件分為三種:  `HashHelper`, `EccGenerator`, `ChameleonHashHelper`

## HashHelper

這個物件是用來昨雜湊值計算使用，其中我們會透過 SHA256 的方式將輸入值雜湊化。

```csharp
public abstract class HashHelper
{
    public static BigInteger Sha256(string message)
    {
        var bmsg = Encoding.ASCII.GetBytes(message);
        
        var sha256Digest = new Sha256Digest();
        sha256Digest.BlockUpdate(bmsg, 0, bmsg.Length);
        
        var hash = new byte[sha256Digest.GetDigestSize()];
        sha256Digest.DoFinal(hash, 0);
        
        return new BigInteger(hash);
    }
}
```

## EccGenerator

這個物件會被使用來建立 橢圓曲線加密演算法 所需要的參數，如: 曲線基點與金鑰對等，code 如下:

```csharp
public static class EccGenerator
{
    public static KeyPair GenerateKeyPair(int keySize)
    {
        var gen = new ECKeyPairGenerator("ECDSA");
        gen.Init(new KeyGenerationParameters(new SecureRandom(), keySize));

        var keyGen = gen.GenerateKeyPair();

        var privateKey = (ECPrivateKeyParameters) keyGen.Private;
        var publicKey = (ECPublicKeyParameters) keyGen.Public;

        var generateKeyPair = new KeyPair()
        {
            PublicKey = publicKey.Q, 
            PrivateKey = privateKey.D,
            BasePoint = publicKey.Parameters.G,
            KeySize = keySize 
        };
        
        return generateKeyPair;
    }
    
}
```

## ChameleonHashHelper

今天的主角，負責計算變色龍雜湊函數及計算訊息簽章的生成與驗證，code 如下:

```csharp
public static class ChameleonHashHelper
{
    
    public static BigInteger Sign(ChameleonHashRequest request)
    {
        var msgHash = HashHelper.Sha256(request.Message);
        var dn = msgHash.Multiply(request.KeyPair.PrivateKey);
        return request.SessionKey.Add(dn).Mod(request.Order);
    }
    
    public static bool Verify(ChameleonHashRequest request, ECPoint rightChameleonHash)
    {
        return GetChameleonHash(request).Equals(rightChameleonHash);
    }

    public static ECPoint GetChameleonHash(ChameleonHashRequest request)
    {
        var msgHash = HashHelper.Sha256(request.Message);
        var rP = request.KeyPair.BasePoint.Multiply(request.Signature);
        var chameleonHash = request.KeyPair.PublicKey.Multiply(msgHash).Add(rP).Normalize();
        return chameleonHash;
    }

}
```

## Conclusion

上述就是之後計算變色龍雜湊值所需要的Code， 至於該怎麼讓我們的專案做使用，我這邊打算使用 SDK 的方式導入。

在這邊提供:

- Nuget: [https://www.nuget.org/packagesh/EccSDK](https://www.nuget.org/packages/EccSDK)
- GitHub:  https://github.com/CodeMachine0121/EccSDK

好啦，今天就到這邊啦~~~

結語:  憂鬱星期二放鬆下哈