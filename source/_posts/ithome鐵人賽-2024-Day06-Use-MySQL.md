---
title: ithome鐵人賽-2024 Day06 Use MySQL
tags: "ithome 鐵人賽-2024"
abbrlink: 84f4b7b3
date: 2024-08-11 23:19:31
---
Hi 來到第六天，昨天講到我們需要透過 Repository 層與資料庫進行交互取得實際的區塊鍊資料。

那今天就來解說下這次專案對於 sql 上的使用吧。

這次主要呢會使用到的資料庫版本為: MySQL ，以下是針對 Block 物件所產出相對應的DB Scheme

```sql
CREATE TABLE Blocks (
   Id INT PRIMARY KEY,
   Data TEXT NOT NULL,
   Hash VARCHAR(64) NOT NULL,
   PreviousHash VARCHAR(64) NOT NULL,
   TimeStamp DATETIME NOT NULL,
   Nonce INT NOT NULL
);
```

有了這支 scheme 後我們就該對我們但 mysql 下個指令來執行，但! 我們還沒有所謂的 SQL server欸。

那方法有幾種，以下是我能想到的方法:

- VM
- Container
- Cloud

那由於方便性來說，我打算將此次的專案以及 db 都透過 Docker 容器化的方式打包成 image 做使用，至於為甚麼不透過 像是 AWS 或是 GCP 服務.... 主要還是$$啦，如果真有需要到時再說，但實做不會相差太大。

至於該怎麼去做 docker 的使用，那是明天的事情惹。

結語:  明天 happy Friday!!!
