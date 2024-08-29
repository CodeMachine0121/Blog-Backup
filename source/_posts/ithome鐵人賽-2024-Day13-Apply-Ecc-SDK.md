---
title: ithome鐵人賽-2024-Day13 Apply Ecc SDK
tags: "ithome 鐵人賽-2024"
abbrlink: 8b64eeab
date: 2024-08-15 21:31:57
---

Hi all, 來到第13天 昨天由於依賴衝突的關係，導致延後套用 SDK~~~今天就來把專案引入昨天寫好的 SDK吧。
<!--more-->
今日的目標就是: 替區塊補上 Cameleon Hash, 此次套用的SDK 版本為: 1.0.4

## Programs

首先我們必須於 `Programs` 中替 KeyPair, SessionKey 物件做DI的註冊。

至於為甚麼是 Singleton，主要原因是我期望每個 request 進來時使用的 key都是同組。code 如下:

```csharp=
var keyPair = EccGenerator.GenerateKeyPair(256);
var sessionKey = SessionKeyGenerator.GenerateSessionKey();
builder.Services.AddSingleton(keyPair);
builder.Services.AddSingleton(sessionKey);
```



## Controller

接著就是使用的地方，我們必須於建構子中注入 `keypair`, `SessionKey` 物件，並導入Dto物件，最後再從Dto物件中透過 `EccGenerator` 物件進行變色龍雜湊函數的計算，code 如下:

```csharp=
[Route("api/v1/[controller]")]
public class ChainController(IChainService chainService, KeyPair keyPair, SessionKey sessionKey) : ControllerBase 
{

    [HttpGet("{id}")]
    public async Task<ApiResponse> GetBlockById(int id)
    {
        var block = await chainService.GetBlockById(id);
        return ApiResponse.SuccessWithData(block);
    }

    [HttpPost("new")]
    public async Task<ApiResponse> GenerateNewBlock([FromBody] GenerateNewBlockRequest request)
    {
        var newBlock = await chainService.GenerateNewBlock(request.ToDto(keyPair, sessionKey));
        return ApiResponse.SuccessWithData(newBlock);
    }
}
```

## Request:

- 需要新增兩個 property 的 setter

```csharp=
public class GenerateNewBlockRequest
{
    public string Data { get; set; }

    public GenerateNewBlockDto ToDto(KeyPair keyPair, SessionKey sessionKey)
    {
        return new GenerateNewBlockDto()
        {
            KeyPair = keyPair,
            SessionKey = sessionKey,
            Data =  Data
        };
    }
}
```

## DTO

需要替第一個 Block計算簽章值，會有點 confus的地方是在於，原本我們是把 new Block 這段code寫在service層，

但基於單一職責的問題，我把他抽 method 之後在塞進 dto 內，code如下。

```csharp=
public class GenerateNewBlockDto
{
    public string Data { get; set; }
    public DateTime TimeStamp { get; set; }
    public KeyPair KeyPair { get; set; }
    public SessionKey SessionKey { get; set; }

    public BlockDomain GetGenesisBlock()
    {
        return new BlockDomain
        {
            Data = "Genesis Block",
            Hash = "0",
            PreviousHash = "0",
            TimeStamp = DateTime.Now,
            Nonce = 0,
            ChameleonSignature = ChameleonHashHelper.Sign(new ChameleonHashRequest
            {
                KeyPair = KeyPair,
                Message = "Genesis Block",
                SessionKey = SessionKey.Key,
                Order = KeyPair.PublicKey.Curve.Order,
            })
        };
    }
}
```

## Service

經過一番 refactor 後，變成這樣

```csharp=
public class ChainService(IChainRepository chainRepository) : IChainService
{
    private const int Nonce = 0;

    public async Task<BlockDomain> GetBlockById(int i)
    {
        return await chainRepository.GetBlockBy(i);
    }

    public async Task<BlockDomain> GenerateNewBlock(GenerateNewBlockDto dto)
    {
        var chainLength = await chainRepository.GetChainLength();
        
        var newBlock = chainLength == 0
            ? dto.GetGenesisBlock()
            : (await chainRepository.GetBlockBy(chainLength)).GenerateNextBlock(dto, Nonce);

        await chainRepository.InsertBlock(newBlock);
        return newBlock;
    }
}
```

## Domain

接著就是計算下個區塊以及轉換 Entity的地方需要計算與新增簽章，code 如下

```csharp=
public class BlockDomain
{
    public string Data { get; set; }
    public string Hash { get; set; }
    public string PreviousHash { get; set; }
    public DateTime TimeStamp { get; set; }
    public int Nonce { get; set; }

    public ChameleonSignature ChameleonSignature { get; set; }
    
    public BlockDomain GenerateNextBlock(GenerateNewBlockDto dto, int nonce)
    {
        return new BlockDomain
        {
            Data = dto.Data,
            PreviousHash = Hash,
            TimeStamp = dto.TimeStamp,
            Hash = HashHelper.ToSha256($"{dto.TimeStamp}:{Hash}:{dto.Data}:{nonce}"),
            Nonce = nonce,
            ChameleonSignature = ChameleonHashHelper.Sign(new ChameleonHashRequest
            {
                KeyPair = dto.KeyPair,
                Message = $"{dto.TimeStamp}:{Hash}:{dto.Data}:{nonce}",
                SessionKey = dto.SessionKey.Key,
                Order = dto.KeyPair.PublicKey.Curve.Order,
            }),
        };
    }

    public Block ToEntity()
    {
        return new Block
        {
            Data = Data,
            Hash = Hash,
            PreviousHash = PreviousHash,
            TimeStamp = TimeStamp,
            Nonce = Nonce,
            ChameleonSignature = ChameleonSignature.Value.ToString()
        };
    }
}
```

## Entity

新增 property

```csharp=
public class Block
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    public string Data { get; set; }

    [Required]
    public string Hash { get; set; }

    [Required]
    public string PreviousHash { get; set; }

    [Required]
    public DateTime TimeStamp { get; set; }

    [Required]
    public int Nonce { get; set; }

    public string ChameleonSignature { get; set; }

    public BlockDomain ToDomain()
    {
        return new BlockDomain
        {
            Data = Data,
            Hash = Hash,
            PreviousHash = PreviousHash,
            TimeStamp = TimeStamp,
            Nonce = Nonce
        };
    }
}
```

## Conclusion

經過一番努力，總算是可以正常替區塊計算簽章值了，明天接著進行 edit 區塊的部分

結語: SDK 輸出的東西，能的話就多墊一層 model，可以避免翻車
