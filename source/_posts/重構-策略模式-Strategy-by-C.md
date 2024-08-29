---
title: '[重構] 策略模式 Strategy by C#'
tags: 'Refactoring'
abbrlink: 8cba6edc
date: 2024-08-12 10:50:50
---
Hi all, 由於近日 91蒞臨我們部門擔任為期一周的 coach，因此有了此次的機遇，整個被點醒的過程蠻讚的寫篇文章來記錄。

<!--more-->
事情是這樣，我跟另位同事盯著同個螢幕同段 code 大約半個鐘頭，但還是想不出可以 refactor 的方法 ，於是請教了 coach 91來幫我們解惑該如何重構這段 code。以下將透過遊戲職業來做這次的情境題，其中我們會有個 工廠類別 PlayerFactory 負責產出相對職業的物件，且職業物件皆實作 IPlayer介面 。

```csharp
public class PlayerFactory
{
    public IPlayer Get(int level, string weapon)
    {
        if (level >= 10)
        {
            if (weapon == "sword")
            {
                return new Warrior();
            }

            return new Archer();
        }

        return weapon switch
        {
            "sword" => new RookieWarrior(),
            "bow" => new RookieArcher(),
            _ => new Rookie()
        };
    }
}
```

這個情境的商業邏輯是以 玩家的等級 以及 使用的武器 進行產生物件的評判標準，其中職業有…
- Warrior: 等級 ≥ 10，且使用劍
- Archer: 等級 ≥ 10，且使用弓
- RookieWarrior: 等級 < 10，且使用劍
- RookieArcher: 等級 < 10，且使用弓
- Rookie: 等級 < 10

## 解題思路
以上面這段 PlayerFactory 為例，可以發現輸出職業物件時，這些物件都會有自己的產生條件，而且他們都繼承同一個介面: IPlayer。所以我們其實可以讓這些物件自己去決定當下的情況是否需要產出物件本身。

首先在IPalyer上新增個判斷用的 method: IsNeedToGenerate()，讓實作類別各自去實作
```csharp
public interface IPlayer
{
    public int AttackDamage();
    public bool IsNeedToGenerate(int level, string weapon);
}
```
此時我們就可以將各自職業的條件實作在這個 method上，以下以 Warrior 舉例。
```csharp
public class Warrior : IPlayer
{
    public int AttackDamage()
    {
        return 24;
    }

    public bool IsNeedToGenerate(int level, string weapon)
    {
        return level >= 10 && weapon == "sword";
    }
}
```

把判斷用的 method都實作完畢之後，理論上我們就可以透過物件來做判斷了。這個時候我們宣告一個 list 物件把這些職業包起來，透過 for-loop 讓所有的職業物件來判斷那個才是需要被產生的即可，code 如下

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
**此次練習的專案任意門**: [GitHub Repository](https://github.com/CodeMachine0121/Stragetory-Refactoring)
