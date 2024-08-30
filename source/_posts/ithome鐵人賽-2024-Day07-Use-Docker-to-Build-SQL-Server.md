---
title: ithome鐵人賽-2024 Day07 Use Docker to Build SQL Server
tags: 'docker, mysql'
abbrlink: a660692f
date: 2024-08-11 23:20:32
categories: "ithome 鐵人賽-2024"
---
Hi 來到第七天，昨天已經說明了該怎麼使用 mysql 來 create 這次要用來存放 Block 的 table ，但我們還缺個可運行的 db server。

今天就來搭建一下 docker 這個好用的玩意兒吧!

<!--more-->
## How would Chat GPT Introduce Docker

> Docker 是一個開源的容器化平台，旨在簡化應用程式的部署和管理。它通過將應用程式及其所有依賴包封裝在一個稱為「容器」的標準化單位內，確保應用程式可以在不同環境中一致地運行。Docker 的容器與虛擬機器不同，它們不需要整個操作系統，而是與主機共享操作系統內核，這使得容器更輕量且啟動速度更快。
>

### 自己的說法

其實 Docker 可以想像做是更輕量化的 VM (虛擬機) ，他不需要多餘的GUI 介面或是 Account 管理 之類的系統，完全是以最乾淨的 Linux 作為基底進行操作。

不過在使用前還是有幾樣知識需要知道:

1. Docker 用來運行的vm，我們稱之為 container
2. 每個 container 都需要一個 image 來做為他的作業系統
3. container 與主機的網路是互不相連的，需要透過開放 port 的方式才能連線

## 主要指令操作

看完 chatGPT的簡單介紹後來整理下比較常用到的docker 指令

- **檢查 Docker 版本**

    ```bash
    docker --version
    ```

- **啟動 Docker Container，**例如：`docker run -d -p 80:80 nginx`

    ```bash
    docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
    ```

- **列出運行中的 Container**

    ```bash
    docker ps
    ```

- **列出所有 Container（包含停止的）**

    ```bash
    docker ps -a
    ```

- **停止 Container**

    ```bash
    docker stop CONTAINER_ID
    ```

- **啟動已停止的 Container**

    ```bash
    docker start CONTAINER_ID
    ```

- **移除 Container**

    ```bash
    docker rm CONTAINER_ID
    ```

- **列出本地所有的 Docker Images**

    ```bash
    docker images
    ```

- **移除 Image**

    ```bash
    docker rmi IMAGE_ID
    ```


## Start Implement

上面整理完基本的指令後，我們就來搭建 mysql吧

### Steps

1.  `docker run --name mysql-server  -e MYSQL_ROOT_PASSWORD=<SQL的密碼> -d -p 3306:3306 mysql:latest`
2. 確認下 container 有沒有正確跑起來

   ![Untitled](https://fv5-3.failiem.lv/thumb_show.php?i=vcknhvg7be&view&v=1&PHPSESSID=d08b7b651ea33577e24662cbf6ba4ff75b6d810f)

3.  使用自己喜歡的 SQL IDE 進行連線，連線成功即可使用 SQL

    ![Untitled](https://fv5-3.failiem.lv/thumb_show.php?i=9kvtvwd5nv&view&v=1&PHPSESSID=d08b7b651ea33577e24662cbf6ba4ff75b6d810f)


## Create DB

接著我們就可以接續對 SQL 做 建立DB、Table 等作業

### Steps

1. Create DB

```sql
Create DataBase Blockchain;
```

1. Create Table

```sql
USE Blockchain;

CREATE TABLE Blocks (
    Id INT PRIMARY KEY,
    Data NVARCHAR(MAX) NOT NULL,
    [Hash] NVARCHAR(64) NOT NULL,
    PreviousHash NVARCHAR(64) NOT NULL,
    [TimeStamp] DATETIME NOT NULL,
    Nonce INT NOT NULL
);
```

1. Select Table

```sql
Select * from Blocks
```

![Untitled](https://fv5-3.failiem.lv/thumb_show.php?i=k67865kv9p&view&v=1&PHPSESSID=d08b7b651ea33577e24662cbf6ba4ff75b6d810f)

## Conclusion

好啦，今天我們成功將DB給建立起來了，接著我們就可以透過專案針對DB 進行連線，並對她Insert 第一筆資料，不過那是明天的事情了~~~

今天進度就先到這兒。

結語: Happy Friday
