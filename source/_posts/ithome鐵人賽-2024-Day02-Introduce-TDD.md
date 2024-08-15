---
title: ithome鐵人賽-2024 Day02 Introduce TDD
tags: tdd
abbrlink: dcec2123
date: 2024-08-11 23:12:32
---
Hi all, 來到第二天 想先來介紹介紹自己的開發方式，以便往後的code在順序上是看得懂的。

首先 TDD 全名是 測試驅動開發 (Test Driven Development)，下面來條列式介紹下：

- **定義**：
    - 測試驅動開發是一種軟體開發方法，強調在撰寫 production code 之前先撰寫測試。
- **核心理念**：
    - 測試先行：在撰寫 production code 之前，先撰寫測試
        - 以自己的經驗來說，會再開始寫測試前先用個小白板或是A4紙條列出所有的 Test Case。
    - 紅-綠-重構循環：
        - 紅：撰寫一個失敗的測試。
        - 綠：通過測試。
        - 重構：重構 production code，確保測試仍然通過。
- **步驟 （循環步驟）**：
    1. **撰寫測試**：根據需求撰寫單一測試，該測試應該是失敗的（ 因為 production code還沒寫）
    2. **跑測試**：測試失敗。
    3. 寫 production code：撰寫剛好能使測試通過的code。(一分鐘內要變成綠燈）
    4. **運行測試**：再跑測試，確認其通過。
    5. **重構**：重構剛剛寫的code，確保測試仍然通過。
- **優點**：
    - 提升code品質：確保每個功能都有對應的測試，減少bug。
    - 提高開發效率：在開發過程中及早發現問題，節省debug時間。
    - 提供自信：隨著code的增長，重構和修改code時比較不會怕改東壞西。

## Conclusion

如果有人是想看這篇文章來寫 project且也想要使用TDD但不會TDD的話，在這邊可以先推薦幾個方法來上手

1. 上網搜尋 KATA 系列的題目來練個手 ex. Tennis Kata or Cyber Dojo
2. 書籍：[K**ent Beck 的測試驅動開發：案例導向的逐步解決之道 (Test-Driven Development: By Example)(TDD)**](https://www.tenlong.com.tw/products/9789864345618)

但學習TDD之外還是需要提醒下，就是TDD他不是看完書及或是重複寫同樣的題目就可以學會的（就小弟的經驗是這樣啦），他的精髓在於開發前就需要設想 Feature的各種使用情境，再透過撰寫測試來開發。

最後再發起個問題，什麼時候該用 TDD 什麼時候不該用呢?

: 我自己的答案是：當Feature會有邏輯條件時就該使用TDD

來個結語：TDD 並非萬能，他只是個會讓你寫 code 更有規範的一種開發方式而已。
