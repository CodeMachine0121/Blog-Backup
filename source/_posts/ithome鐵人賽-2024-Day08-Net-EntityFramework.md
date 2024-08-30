---
title: ithome鐵人賽-2024 Day08 .Net EntityFramework
tags: "ithome 鐵人賽-2024"
abbrlink: e6c04a02
date: 2024-08-11 23:21:29
categories: "ithome 鐵人賽-2024"
---
Hi 來到第八天，昨天的我們已經把 SQL Server 等都處理好了，今天我們就 focus在 專案與 SQL 的打通吧！

<!--more-->
首先，這次使用到的會是 EntityFrameWork 這個 .Net 套件，這邊附上全名以便使用nuget 安裝

1. MySql.Data 9.0.0
2. MySql.EntityFrameworkCore 8.0.5


接著我們需要到 `programs.cs`  新增一些 code，來向專案註冊 entityframework。

```csharp
builder.Services.AddDbContext<BlockchainDbContext>(options =>
{
    var connectionString = builder.Configuration.GetValue<string>("Sql");
    
    connectionString = connectionString.Replace("${DB_SERVER}", Environment.GetEnvironmentVariables()["DB_SERVER"]!.ToString());
    connectionString = connectionString.Replace("${DB_NAME}", Environment.GetEnvironmentVariables()["DB_NAME"]!.ToString());
    connectionString = connectionString.Replace("${DB_USER}", Environment.GetEnvironmentVariables()["DB_USER"]!.ToString());
    connectionString = connectionString.Replace("${DB_PASS}", Environment.GetEnvironmentVariables()["DB_PASS"]!.ToString());
    
    options.UseSqlServer(connectionString);
}, ServiceLifetime.Transient);

```

另外，我們還需要再做兩件事情： 宣告 `ConnectionString` 和 `BlockchainDbContext`  ，實作如下

### ConnectionString

- 至 `appsetting.json` 新增

    ```csharp
        "Sql": "Server=${DB_SERVER};Database=${DB_NAME};Uid=${DB_USER};Pwd=${DB_PASS};",
    ```


### BlockchainDbContext

- 新增類別 BlockchainDbContext

```csharp
public class BlockchainDbContext(DbContextOptions<BlockchainDbContext> contextOptions): DbContext(contextOptions) 
{
    
    public DbSet<Block> Blocks { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Block>().HasKey(x=> x.Id);
    }
}
```

- 新增 Entity Model

```csharp
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
}
```

- 設定環境變數：DB_SERVER, DB_USER, DB_PASS ( 依照自己設定的設定就好）

## Conclusion

理論上這樣子設定我們的專案就可以成功連線到資料庫了，可以來整理下我們大致上做了什麼事情

1. 註冊 DbContext 的 DI
2. 設定 Connection String
3. 新建 Entity Model (名稱與前幾天建立的 domain 物件有衝突，戰把 Domain model 從 Block改名至BlockDomain
4. 綁定環境變數

好啦，到目前我們的專案可以成功與 SQL 連線了，接著就可以著手在 Insert Block了，不過那是明天的事情啦～～～～

結語：今天七夕 ❤️
