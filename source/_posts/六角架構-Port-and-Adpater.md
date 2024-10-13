---
title: 六角架構 (Port and Adpater)
tags: clean-architecture
categories: 軟體架構
abbrlink: 406b4875
date: 2024-09-02 23:25:47
top: true
---
現今許多開發團隊表面上採用分層架構，但實際上更接近六角架構，這是因為許多專案或多或少都會使用依賴注入的緣故。
採用依賴注入後，架構的開發自然而然地更傾向於這種 Port 對 Adapter 的設計風格。

![img.png](/images/hexagoanl-architecture.png)
<!--more-->
## 畫圖說故事 

以上圖為例， 外層的大六角形的每個邊都代表不同類型的 **Port**，可以是輸入或是輸出。 不同的用戶端都會有屬於自己的**轉接器 (Adapter)**，接著這些轉接器會將輸入轉為跟應用程式相符合的輸入(即 request轉 dto 或是 response/Entity 轉 Domain)。

## 舉個例子
有個 Request 透過 Adapter A 將 request參數 轉換成 Dto 物件並輸入至應用程式中。
接著這個應用程式需要透過其他的外力協助才能滿足 Request 所需要的 Response (在這邊以DB為例子)，應用程式就會在往外擴展至 Port 再擴展至 Adapter E 索取所需的資料後再一路往回走。

值得注意的是在 Adapter E 回傳 DB Entity 至 Port 時，還需要將 Entity 轉換為 Domain 物件，作為返回應用程式的輸入。

返回應用程式後，就會透過裡面的領域模型進行ㄧ連串的業務邏輯運算，再將運算出來的 Domain 物件回傳至用戶端即可。

