---
title: ithome鐵人賽-2024 Day04 Get the First Block
tags: "ithome 鐵人賽-2024"
abbrlink: 6f938f8a
date: 2024-08-11 23:16:11
---
Hi all,  到了第四天終於可以來搞專案了，今天的目標很簡單，我想要寫出取得 Block 的 API。

<!--more-->
首先來簡單介紹下 Block 的結構:

```json
{
    index: block 的索引值，用來標識這是區塊鏈中的第幾個區塊。
    timestamp: 區塊創建的時間。
    data: 儲存在區塊中的資料，可以是任何類型的資料。
    previous hash: 前一個區塊的雜湊值，用來鏈接到前一個區塊，確保區塊鏈的連續性。
    hash: 當前區塊雜湊值。
    nonce: 一個隨機數，用於工作量證明 (proof of work) 算法，確保區塊的有效性。
}
```

接下來說明下區塊雜湊值的計算:

`Hash = SHA256 ( Timestamp + Previous Hash + Data  + Nonce)`

其中 Nonce 是個變數值，他會隨著當前的計算困難度( Difficulty) 而有所變化，由於是自己的區塊鏈環境，我們不需要太過強的困難度，因此困難度可視為0。

以下就是 TDD 寫出 Get Block 的過程，供參:

[![Yes](https://img.youtube.com/vi/2e_w17iWLSU/0.jpg)](https://www.youtube.com/watch?v=2e_w17iWLSU)

由上面的影片可以看出，我們搭建了專案的三層架構，且在 Repository層 hard code 一個 block 資料作為回傳值，明天的時候再來定義 Block 的生成哈。

今天應該就先到這， 先付上[專案 GitHub 任意門](https://github.com/CodeMachine0121/CustomBlockChainLab.git)


總結: 青藍色星期二，明天不是假日，後天也不是。
