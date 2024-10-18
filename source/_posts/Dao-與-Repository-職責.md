---
title: Dao 與 Repository 職責
tags: clean-architecture
categories: 軟體架構
abbrlink: 21be0a47
date: 2024-09-03 00:58:23
---
由於小弟近期工作遇到ㄧ些架構層面上的問題，其中我和 team 上的 member [Bear](https://github.com/YNCBearz) 再定義 Dao 及 Repository 的路上有些許的討論。

我覺得蠻有意義的，故紀錄於此。
<!--more-->

## Introduction
先來簡單比較一下兩者的差異
### DAO, Data Access Object
- 針對 Table 的 CRUD 操作
- 會是直接與 DB 互動的層級
- Dto 進，Entity/Domain 出
### Repository
- Domain 物件整合的地方
- 輸出 Domain 物件


## 架構
通常來說，我們的架構通常會是長的像這樣

```text
controller -> service -> repository -> call Stored Procedure (SP) 
```
會拉出這個架構的主要原因是我們想針對每次從 SP 取得的 List of Entities 做轉換Domain物件這件事情撰寫單元測試。

但又礙於 `DbClient` 難以透過介面進行 mock，因此我們把呼叫 SP 的部分再抽出一層介面(也就是Dao) ，並在 Repository 層針對 Dao 進行依賴注入，最後我們的架構長得像這樣:
```text
controller -> service -> repository -> dao -> call stored procedure
```

## 困惑點
當我跟 [Bear](https://github.com/YNCBearz) 興奮的拿著這個架構詢問部門上另個 Senior [Kyo](https://github.com/kyoforing) 時，他提出了一個問題點
> 如果 Dao 的職責是針對一張 Table 的 CRUD，那一個 stored procedure 裏頭 Join 多張表怎麼辦 ?

這個問題可以衍生出兩個問題點
- **堅持 Dao 與 Table 就是 1:1 的關係**，那表示 join 的工全部都要拉回到 Repository 層做，職責乍聽下蠻合理的，但仔細想想錢包還沒大到可以扛住大資料運算呀
- **不限制 Dao 跟 Table 的關係**。 假設有個 SP 裏頭是 `select from a join b` 這樣 Dao 出來的物件還能算是 Entity 嗎? 如果直接是輸出 Domain 物件那還需要多墊ㄧ層 Repository 嗎?

### 你的好同事 ChatGPT
我的問題是:
```text
假設今天我有個 stored procedure，他 join了兩張表，且出來的物件就是domain物件
我該使用 dao實作呼叫 還是 repository呢?
```
- 選擇 DAO：當你的 Stored Procedure 返回的結果已經是你所需的 Domain 物件，且你不需要在應用層進行進一步的業務邏輯處理時，DAO 是簡單且直接的選擇。

- 選擇 Repository：當你需要將這些結果進一步與其他業務邏輯整合，或者需要保持應用層與數據存取層的解耦時，使用 Repository 會更加靈活和強大。

### 總和理解 
當我們今天有個 SP 且在他輸出的東西已經 Domain 物件的情況下，我們可以直接透過 Service 直接呼叫 Dao 後直接進行業務邏輯的計算，反之則是透過 Repository 層進行 Entities 與 Domain 物件的轉換。

以上是小弟對於 DAO 和 Repository 的見解，但沒有最好的架構，只有最適合當前情況的架構。


