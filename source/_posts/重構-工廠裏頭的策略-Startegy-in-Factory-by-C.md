---
title: '[重構] 工廠裏頭的策略 Startegy in Factory by C#'
tags: 'Refactoring'
abbrlink: f0cbbe44
date: 2024-08-12 10:55:05
categories: "重構人人有責"
---
Hi all, 在之前的文章中有講到，我們如何在一個充滿 if-else 及 switch-case 的 code 重構成策略模式讓其本身決定是否符合條件，以下為重構後的 code。

<!--more-->
```csharp

public class PlayerFactory
{
    private readonly List<IPlayer> _players =
    [
        new Archer(),
        new Warrior(),
        new RookieArcher(),
        new RookieWarrior()
    ];

    public IPlayer Get(int level, string weapon)
    {
        foreach (var player in _players)
        {
            if (player.IsNeedToGenerate(level, weapon))
            {
                return player;
            }
        }

        return new Rookie();
    }
}
```

## 重構思路
在上面這段 code可以發現在這個工廠內，決定要產生哪種 player的條件已經被我們封裝到 Player本身了。然而這種作法，對於初次來看這段code的人來說可能就會需要再進 Player才能查看各自的條件為何，加上讓產出物件來判斷自己是否該被產出這點回頭想想也是挺弔詭的。

舉個例子🌰 假設今天有個商人提供了 10種不同的藥水，其中有9瓶藥水是有毒的，在這個情境中，就像是購買藥水的客戶需要把10瓶藥水全部喝過一輪才能夠得出哪一瓶是沒有毒的。基於以上的觀點，我們應該思考的是把驗證條件封裝在工廠本身即可，以下為 91提供給我們的重構技巧。

## 重構手法
首先我們先建立一個 list of PlayerValidator 物件(如下 code)，其中用來取得Player物件的 property我們選用 Func的方式進行定義。選擇使用 Func的好處在於，當驗證條件符合時，工廠才會實際去產生該物件出來回傳。

```csharp
public class PlayerValidator
{
    public bool IsNeedToGenerate { get; set; }
    public Func<IPlayer> Value { get; set; }
}
```

接者，就可以來定義我們的 list of PlayerValidator，並回傳IsNeedToGenerate為True的Player 即可。因此整個 Get 方法如下:
```csharp
public IPlayer Get(int level, string weapon)
    {
        var playerValidators = new List<PlayerValidator>()
        {
            new()
            {
                IsNeedToGenerate = level >= 10 && weapon == "sword",
                Value = () => new Warrior()
            },
            new()
            {
                IsNeedToGenerate = level >= 10 && weapon == "bow",
                Value = () => new Archer()
            },
            new()
            {
                IsNeedToGenerate = level < 10 && weapon == "sword",
                Value = () => new RookieWarrior()
            },
            new()
            {
                IsNeedToGenerate = level < 10 && weapon == "bow",
                Value = () => new RookieArcher()
            },
            new()
            {
                IsNeedToGenerate = true,
                Value = () => new Rookie()
            }
        };

        return  playerValidators.First(x => x.IsNeedToGenerate).Value();
    }
```

最後再Extract Method 修飾一下
```csharp
public class PlayerFactory
{
    public IPlayer Get(int level, string weapon)
    {
        var playerValidators = GeneratePlayerValidators(level, weapon);

        return  playerValidators.First(x => x.IsNeedToGenerate).Value();
    }

    private static List<PlayerValidator> GeneratePlayerValidators(int level, string weapon)
    {
        var playerValidators = new List<PlayerValidator>()
        {
            new()
            {
                IsNeedToGenerate = level >= 10 && weapon == "sword",
                Value = () => new Warrior()
            },
            new()
            {
                IsNeedToGenerate = level >= 10 && weapon == "bow",
                Value = () => new Archer()
            },
            new()
            {
                IsNeedToGenerate = level < 10 && weapon == "sword",
                Value = () => new RookieWarrior()
            },
            new()
            {
                IsNeedToGenerate = level < 10 && weapon == "bow",
                Value = () => new RookieArcher()
            },
            new()
            {
                IsNeedToGenerate = true,
                Value = () => new Rookie()
            }
        };
        return playerValidators;
    }
}
```

**此次練習的專案任意門**: [GitHub Repository](https://github.com/CodeMachine0121/Stragetory-Refactoring)
