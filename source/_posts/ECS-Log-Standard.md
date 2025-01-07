---
title: ECS Log Standard
date: 2025-01-07 22:31:40
tags: "Standard"
---
# ECS Log Standard

ECS（Elastic Common Schema）是一個開放的標準，用於統一和簡化不同來源的日誌資料。以下是一些關於ECS log standard的重要資訊：

## 為什麼使用ECS？

ECS 提供了一個統一的結構，使得來自不同來源的日誌資料可以更容易地被解析和分析。這有助於提高日誌資料的可用性和可理解性。

## ECS 的主要特點

- **一致性**：ECS 定義了一組標準欄位，使得不同來源的日誌資料可以使用相同的欄位名稱。
- **擴展性**：ECS 允許使用者根據需要擴展欄位。
- **相容性**：ECS 與多種日誌管理工具和函式庫相容。

## 如何實施ECS？

實施ECS 需要以下步驟：

1. **識別日誌來源**：確定需要統一的日誌來源。
2. **映射欄位**：將日誌來源的欄位映射到ECS 定義的標準欄位。
3. **驗證和測試**：確保映射後的日誌資料符合ECS 標準。

## 範例

以下是一個簡單的範例，展示如何將日誌資料映射到ECS：

```json
{
  "timestamp": "2025-01-07T22:31:40Z",
  "log.level": "info",
  "message": "User login successful",
  "user.id": "12345",
  "source.ip": "192.168.1.1"
}
```

透過這樣的映射，我們可以確保日誌資料的一致性和可用性。

## 實作

- 以下以 .Net Serialog 進行實作

- Nuget Package
  - `dotnet add package Serilog.AspNetCore`
  - `dotnet add package Serilog.Sinks.Console`
  - `dotnet add package Elastic.CommonSchema.Serilog`
- Initial Logger
我們可以這樣子設定 log 的 format

```csharp
Log.Logger = new LoggerConfiguration()
    .WriteTo.Console(new EcsTextFormatter())
    .WriteTo.File(new EcsTextFormatter( ), "logs/log.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();
```

- 寫個簡單 log

```csharp
[ApiController]
[Route("[controller]")]
public class TestController(ILogger logger) : ControllerBase
{
    [HttpGet]
    public string Get()
    {
        logger.Information("This is a test log message");
        return "Hello World!";
    }
}
```

- Log 長醬

```json
{
   "@timestamp":"2025-01-07T23:33:04.262825+08:00",
   "log.level":"Information",
   "message":"This is a test log message",
   "ecs.version":"8.11.0",
   "log":{
      "logger":"Elastic.CommonSchema.Serilog"
   },
   "span.id":"2f79b8d7f7f1c8b5",
   "trace.id":"febbc2cb0e5c7bfdfec26a7fde8cea1b",
   "labels":{
      "MessageTemplate":"This is a test log message"
   },
   "agent":{
      "type":"Elastic.CommonSchema.Serilog",
      "version":"8.12.3+2f97b9d4b2576cff9c7e82e117057fa333b5ac7e"
   },
   "event":{
      "created":"2025-01-07T23:33:04.262825+08:00",
      "severity":2,
      "timezone":"Taipei Standard Time"
   },
   "host":{
      "os":{
         "full":"Darwin 24.1.0 Darwin Kernel Version 24.1.0: Thu Oct 10 21:02:45 PDT 2024; root:xnu-11215.41.3~2/RELEASE_ARM64_T8112",
         "platform":"Unix",
         "version":"15.1.0"
      },
      "architecture":"Arm64",
      "hostname":"Jamess-MacBook-Air"
   },
   "process":{
      "name":"WebApplication1",
      "pid":60342,
      "thread.id":17,
      "thread.name":".NET TP Worker",
      "title":""
   },
   "service":{
      "name":"WebApplication1",
      "type":"dotnet",
      "version":"1.0.0+dac25e132a81898730dd280bee3c807f44410f27"
   },
   "user":{
      "domain":"Jamess-MacBook-Air",
      "name":"james.hsueh"
   }
}
```

## 結論

ECS log standard 提供了一個強大的工具，用於統一和簡化日誌資料。透過實施ECS，我們可以提高日誌資料的品質和可用性，從而更有效地進行日誌分析和監控。

最後 ESC Log 除了上述飯例外還有其他的feild（例如 http, url 的欄位) 可作使用，但 feild name需符合官方文件說明，有興趣查看的人連結如下。

## 參考

[Elastic Common Schema Logging](https://www.elastic.co/guide/en/ecs-logging/dotnet/current/intro.html#_log_formatters)

[ECS Log Fields Documentation](https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html)
