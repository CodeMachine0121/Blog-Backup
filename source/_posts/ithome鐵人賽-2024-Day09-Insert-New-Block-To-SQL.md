---
title: ithome鐵人賽-2024 Day09 Insert New Block To SQL
tags: 'entityframework, tdd, mysql, .net'
abbrlink: c35b4088
date: 2024-08-11 23:22:19
---

Hi all, 今天第九天 今天就來讓專案可以 Insert Block吧！

那由於主要內容都是與SQL做互動，所以我們的code 主要也會動在 repository 層的 `InsertBlock(BlockDomain)` 。

## Repository

首先我們必須在 Repository 注入一個與資料庫連線的類別 `DbContext` ，code 如下

```csharp

public class ChainRepository(BlockchainDbContext blockchainDbContext): IChainRepository
{
    private DbSet<Block> _blocks = blockchainDbContext.Blocks;

    public async Task InsertBlock(BlockDomain newBlockDomain)
    {
        await _blocks.AddAsync(newBlockDomain.ToEntity());
        await blockchainDbContext.SaveChangesAsync();
    }
}
```

這樣一來，我們就可以成功在 Table裡頭新增資料了。但還有個問題，那就是在 Service 層的新增區塊的流程 code 如下

```csharp
public async Task<BlockDomain> GenerateNewBlock(GenerateNewBlockDto dto)
{
    var firstBlock = chainRepository.GetBlockBy(0);
    var newBlock = firstBlock.GenerateNextBlock(dto, Nonce);
    
    await chainRepository.InsertBlock(newBlock);
    return newBlock;
}
```

## Update Service Code

可以看到我們在計算 `newBlock`  是透過 id 為 0 的區塊計算出來的，但這不是我們期望的，我們希望的是取得目前鏈上的最後一塊區塊對吧？
所以我們必須要來小修改下，當然這邊也會是由 TDD 出發，code 如下：

### Unit Test Code

```csharp
    [Test]
    public async Task should_not_request_block_when_the_length_is_0()
    {
        _chainRepository!.GetChainLength().Returns(0);
        await _chainService.GenerateNewBlock(new GenerateNewBlockDto()
        {
            Data = "new",
            TimeStamp = DateTime.Now
        });

        _chainRepository.DidNotReceive().GetBlockBy(Arg.Any<int>());
        await _chainRepository.Received().InsertBlock(Arg.Is<BlockDomain>(b => b.Data == "Genesis Block"));
    }

```

### Production Code

```csharp
    public async Task<BlockDomain> GenerateNewBlock(GenerateNewBlockDto dto)
    {
        if (await chainRepository.GetChainLength() == 0)
        {
            var genesisBlock = new BlockDomain
            {
                Data = "Genesis Block",
                Hash = "0",
                PreviousHash = "0",
                TimeStamp = DateTime.Now,
                Nonce = 0
            };
            await chainRepository.InsertBlock(genesisBlock);
            return genesisBlock;
        }
        var firstBlock = chainRepository.GetBlockBy(0);
        
        var newBlock = firstBlock.GenerateNextBlock(dto, Nonce);
        
        await chainRepository.InsertBlock(newBlock);
        return newBlock;
    }
```

接著我們還可以再寫下個 test case → 鏈長度不為 0的時候

### Unit Test Code

```csharp
    [Test]
    public async Task should_generate_new_block_base_on_latest_block()
    {
        _chainRepository!.GetChainLength().Returns(1);

        GivenBlock(new BlockDomain
        {
            Hash = "123",
        });

        var newBlock = await _chainService.GenerateNewBlock(new GenerateNewBlockDto()
        {
            Data = "new",
            TimeStamp = DateTime.Now
        });

        _chainRepository.Received().GetBlockBy(Arg.Is<int>(i => i==1-1));
        newBlock.PreviousHash.Should().Be("123");
    }

```

## Production Code

```csharp
    public async Task<BlockDomain> GenerateNewBlock(GenerateNewBlockDto dto)
    {
        var chainLength = await chainRepository.GetChainLength();

        if (chainLength == 0)
        {
            var genesisBlock = new BlockDomain
            {
                Data = "Genesis Block",
                Hash = "0",
                PreviousHash = "0",
                TimeStamp = DateTime.Now,
                Nonce = 0
            };
            await chainRepository.InsertBlock(genesisBlock);
            return genesisBlock;
        }
        
        var firstBlock = chainRepository.GetBlockBy(chainLength-1);
        var newBlock = firstBlock.GenerateNextBlock(dto, Nonce);
        
        await chainRepository.InsertBlock(newBlock);
        return newBlock;
```

該有的邏輯都完成了，就來重構下吧！

## Refactor Code

```csharp
public async Task<BlockDomain> GenerateNewBlock(GenerateNewBlockDto dto)
{
    var chainLength = await chainRepository.GetChainLength();
    var newBlock = chainLength == 0
        ? new BlockDomain
        {
            Data = "Genesis Block",
            Hash = "0",
            PreviousHash = "0",
            TimeStamp = DateTime.Now,
            Nonce = 0
        }
        : chainRepository.GetBlockBy(chainLength - 1).GenerateNextBlock(dto, Nonce);

    await chainRepository.InsertBlock(newBlock);
    return newBlock;
}
```

以上我們就完成了，我們的新需求：基於上一個區塊的 hash值進行計算。

## 題外話：Get Block By

如果記憶力好的話，我們還有個 `GetBlockBy` 還沒有實作，這就來實作個，code 如下

```csharp
public async Task<BlockDomain> GetBlockBy(int id)
{
    var block = await _blocks.FirstAsync(x=>x.Id == id);
    return block.ToDomain();
}
```

## E2e Test

如此一來，系統就可以好好運行啦，來個 E2E Test下

### First Block

![image.png](https://fv5-4.failiem.lv/thumb_show.php?i=u4yfg222hn&view&v=1&PHPSESSID=bae84d3f0f5d214bece104d1a114c1b2e86b8f4d)

### Second Block

![image.png](https://fv5-4.failiem.lv/thumb_show.php?i=aud6rqqypv&view&v=1&PHPSESSID=bae84d3f0f5d214bece104d1a114c1b2e86b8f4d)

## Conclusion

總算是打通與DB的連線了～～～ 接著我們就可以往**可編輯** 的方向走了，但這是明天的事情 ，明天再說**

結語：明天上班 🫠🫠🫠🫠🫠
