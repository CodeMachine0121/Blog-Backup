---
title: Type and Interface
tags: typescript
abbrlink: 737e6e43
date: 2024-08-16 01:22:44
categories: "Js/Ts"
---
Hi all, 這篇文章主要會用來比較 type 與 inteface的差別，做為自己的小小筆記。

<!--more-->
## 使用方式
兩者之間主要功能大略一致，以下為typscript語法中宣告的方式

```typescript
type PersonType = {
    job: string;
    age: number;
}

interface PersonInterface{
    job: string;
    age: number;
}

const  type_person: PersonType= {
    job: 'developer',
    age: 25
}

const interface_person: PersonInterface= {
    job: 'developer',
    age: 25
} 
```

可以看到其實使用方式都是一樣的，唯一不同的點在宣告時 type 是需要使用= 來給值。

但保持實驗精神，我們在把這段 typescript 翻譯成 javascript 來觀察看看 js 層如何實作 (如下)

```typescript
"use strict";
var type_person = {
    job: 'developer',
    age: 25
};
var interface_person = {
    job: 'developer',
    age: 25
};
```

給個結論: 其實都一樣😂

## 進階使用
以上面的實驗看下來，type 與 interface確實是大同小異的。以下就來介紹兩者在繼承或是擴充上的使用方式。

### Interface:
- 物件導向中規章：介面用於定義物件的需要的規範，需要實作哪些方法。
- 可繼承：介面可以透過 extends 繼承其他介面 (以下為 extends的例子)。

```typescript
interface PersonInterface{
    job: string;
    age: number;
}
interface Wizard extends PersonInterface{
    burn(): void;
}


const papa: Wizard = {
    job: 'wizard',
    age: 25,
    burn: () => console.log('burn')
}
```

### Type:
- 不可繼承 ：不同 type間不可以繼承(extends)
- 對型別進行複合形式的操作：雖然 type 不能像介面那樣透過 extends 被繼承，但它可以通過聯合（|）和交集（&）等操作組合其他型別，來建立複雜的型別 (以下為例)。

```typescript
type PersonType = {
    job: string;
    age: number;
}

type Shooter = {
    reload(): void;
}
type Archor = {
    shoot(): void;
}
const james: Archor & PersonType | Shooter = {
    job: 'archor',
    age: 25,
    shoot: () => console.log('shoot')
} 
```

在上面的實作中，可以發現 james 的型別為 Archor & PersonType，這個型別表示說常數需要同時實作兩個 type 底下的屬性，跟 implement 意思差不多。再來可以發現其實後面又多了個 | Shooter 這個的意思就表示了 james 可以選擇性的實作 Shooter底下的屬性。

## 結論
以上實驗 Interface 及 Type 兩者的使用方式後，最後的問題: 兩個功能上幾乎都差不多，那到底甚麼時候該使用哪一個來做為型別定義呢?

> 我自己的觀點呢 -> 還是那句話 case by case。

如果今天的撰寫的是多人共同管理的中大型專案又或是與後端API定義交互的物件時，我會選擇使用 interface 來換得更嚴謹的規範。

相反的今天的專案可能是ㄧ些小型專案又或是一些需要負責定義複雜型別的場合，我認為type可以帶來更加彈性的寫法。





