---
title: ithome鐵人賽-2024-Day10 Introduce Chameleon Hash
date: 2024-08-12 23:04:54
tags: cryptography, chameleon hash
---
Hi all 今天第十天，我們來稍微介紹下 變色龍雜湊函數 ( Chameleon Hash) 為何物吧!

## How Chat GPT Introduce

> Chameleon Hash 是一種密鑰控制的可碰撞雜湊函數（keyed collision-resistant hash function）。這意味著給定一個密鑰，使用者可以控制雜湊值的碰撞，即可以找到不同的輸入消息，讓它們產生相同的雜湊值。


## 自己的總結

想想看以往常見的雜湊函數: md5、sha1、sha256... 等等的特性都是秉持著不同輸入皆會得到不同的輸出，即不可碰撞性。而變色龍雜湊函數卻是反其道而行，在特定的情況下 ( 擁有相同的 key ) 可以使演算法遵循不同的輸入得到相同輸入的特性。

## How

以下為小弟在碩士時提出之演算法公式 ，簽章計算如下:

`sign = (sessionKey - dn) mod n`
`dn = H(m) * kn`

Chameleon Hash 計算方式如下:

`chameleonHash = [Kn x H(m)] + [P x sign]`

最後我們只需要將收到的 requests 資訊透過上述公式，即可得出一個 Chameleon Hash，在跟自己的 Chameleon Hash比對是否一致即可。

變數對應如下

| Variable | Meaning |
| --- | --- |
| (Kn, kn)  | 對稱式金鑰對 |
| H(m)  | 訊息的雜湊值 |
| P  | 橢圓曲線之基點 |
| SessionKey  | 一次性的金鑰|

## Conclusion

以上就是這次專案會使用到的雜湊演算法，上述只是很簡單的介紹簽章公式，更細節的可以翻找下論文，這邊附上任意門: [論文網址](https://ndltd.ncl.edu.tw/cgi-bin/gs32/gsweb.cgi/login?o=dnclcdr&s=id=%22110YUNT0392023%22.&searchmode=basic)

接著我們就可以來想想怎麼透過 code 將其實作囉，那一樣是明天的事情了~~~

結語:  夢迴研究生嗚嗚
