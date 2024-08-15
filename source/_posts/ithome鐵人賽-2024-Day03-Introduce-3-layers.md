---
title: ithome鐵人賽-2024 Day03 Introduce 3-layers
tags: 'tdd, architecture, unit test'
abbrlink: b75c561e
date: 2024-08-11 23:14:10
---
Hi all, 來到第三天，今天來稍微介紹下這次 side project 的專案架構好了。

這次主要會是以 tdd 的角度搭建所謂的 三層式架構，分別是 Controller, Service, Repository。 各個層級接受的參數型別跟回傳的型別也有所不同。

以下是三個架構分別接受/ 回傳的物件型別:

| Layer | Receive Object | Return Object | Responsibility |
| --- | --- | --- | --- |
| Controller | Request | Response | 路由的導轉 |
| Service | Dto (Data Transfer Object) | Domain | 商業邏輯處理 |
| Repository | Dto | Domain | 跟DB交互取得資料 |

以下影片是 自己透過 TDD建立三層式架構的過程 供參:

[![Yes](https://img.youtube.com/vi/QgPO9K-JmwA/0.jpg)](https://www.youtube.com/watch?v=QgPO9K-JmwA)

透過以上的影片(可能順序上有點錯亂)，但大致上可分為 兩大步驟:

1. 新增 Controller ，接收 request 物件，並回傳  response 物件
2. 新增 Service，接收 Dto 物件，並回傳 Domain物件

至於 Repository 層，依照影片來說只做到呼叫介面尚未實作，其中是因為在 Repository 層主要是跟DB建立連線拿取資料，不會有邏輯上的判斷，若要針對該層寫測試應該專由 (整合測試，Integration Tests) 負責，在這邊就先不討論該如何以單元測試實作。

以上就是本人對於三層式架構的粗淺看法，如果有興趣練習TDD 也可以以這種方式來搭建自己的後端專案，並陸續在 Service 撰寫更多單元測試來逼出自己專案的Domain邏輯囉。

題外話，其實專案夠大的話 repository 底下還會有層 DAO(Data Access Object)，但這次的專案還沒有那麼大就暫不考慮囉。

總結: 藍色星期一 ~~ 需要咖啡~~~  [或許你就是那位咖啡天使](https://www.buymeacoffee.com/James.Hsueh)

