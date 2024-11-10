---
title: LLM 教我啥是Kafka
abbrlink: 992d0373
date: 2024-11-06 14:07:43
tags: system-design
categories: 系統設計
---
這是一個使用 ChatGpt 來教我怎麼認識及部屬 Kafka的筆記，在下對於kafka的認知程度大概是只知道這是啥但沒碰過，如果有跟我一樣程度的大大們也能參考這篇筆記。
-----
Kafka 是一個由 Apache 開發的分散式事件流平台，廣泛用於即時資料流處理和高效能的資料傳輸。以下是 Kafka 的核心概念和特性：

- 消息系統：Kafka 是一種分散式的消息系統，支持發布（publish）和訂閱（subscribe）消息，常用於數據的即時流處理。
- 分區（Partition）和容錯性：消息被分成多個分區儲存，允許橫向擴展來處理大規模資料。分區複製增加了容錯性，即便某個節點失效，其他複製節點仍可提供資料。
- 高效能：Kafka 使用順序寫入和磁碟存儲結構來提供高吞吐量，適合高頻交易和資料流的大數據處理。
- 消費者群組（Consumer Group）：多個消費者可以組成群組，共享讀取相同主題的不同分區的訊息，使得訊息能夠被平行處理，達到橫向擴展的效果。
- 持久性：Kafka 可以將消息持久儲存在磁碟上，用戶可以配置消息的保留時間，因此即使消費者延遲也不會丟失消息。
- 流處理（Stream Processing）：Kafka 提供 Kafka Streams API，支持將數據流作為實時的可持久查詢的數據源，允許進行資料的過濾、聚合和轉換。

<!--more-->
## 系統結構：
Kafka 主要包含以下角色：

- Producer（生產者）：向 Kafka 的主題（Topic）發送訊息的應用程式。生產者可以將訊息發布到一個或多個主題。
- Consumer（消費者）：從主題訂閱並消費訊息的應用程式。消費者可以單獨工作，也可以組成消費者群組（Consumer Group），每個群組內的消費者會共享負載。
- Broker（代理）：Kafka 的運行單位，每個 broker 是一個 Kafka 節點，負責存儲和管理訊息。Kafka 集群由多個 broker 組成，能夠橫向擴展以增加容量和效能。
- Topic（主題）：Kafka 的邏輯單位，用於組織訊息流。每個主題可以分成多個分區（Partition），分區是 Kafka 提高並行處理能力的基礎。
- Partition（分區）：每個主題可以劃分為多個分區，允許消息分散存儲在不同的 broker 上，提供更高的吞吐量和並行處理。
- ZooKeeper / KRaft：ZooKeeper 原本負責 Kafka 的元數據管理、broker 狀態維護和 leader 選舉等任務。Kafka 2.8 開始提供 KRaft（Kafka 自有的 Raft 架構）以取代 Zookeeper 管理元數據。

## 訊息流過程
Kafka 中的訊息流從生產者到消費者，流程大致如下：

- Producer 發送訊息：Producer 將訊息寫入指定的主題和分區。每條訊息包含鍵（key）和值（value），鍵用於分區策略，決定訊息寫入哪個分區。
- 分區邏輯：如果 Producer 指定鍵，則 Kafka 使用鍵的Hash 值將訊息分配到特定分區；如果沒有鍵，則 Kafka 使用輪詢或其他策略隨機分配。
- Broker 接收並存儲：每個分區有一個 **Leader Broker**，負責接收訊息並存儲到其磁碟。其他 Broker 作為Follower，同步Leader Broker 的訊息。
- Comsumer Group 拉取訊息：Comsumer 以「拉」模式（pull model）從 Broker 取得訊息，並根據分區和Comsumer Group分配邏輯進行消費。Kafka 保證同一個分區的訊息只能被一個Comsumer 消費，以保證訊息的順序性。

## Kafka 的典型應用場景
- 實時數據處理：例如金融市場數據的即時處理或IoT設備的即時數據流，Kafka 能處理高頻資料流並迅速傳遞給下游消費者。
- Log 整合：Kafka 可以作為統一的Log 收集平臺，集中收集系統或應用Log，將其傳送到Data Pool、大數據分析或監控系統中。
- Event Driven 架構：微服務架構中，Kafka 能充當事件總線，用於跨服務的事件傳輸，使服務間的交互鬆耦合。
- Data Pipeline：Kafka 能夠在資料庫、數據倉庫或資料流平台之間構建實時或批次數據傳輸管道。

## 優缺點：
- 優點：高效、容錯性高、可伸縮性強。
- 缺點：需要額外的資源配置和管理，數據一致性（強一致性）保證不如傳統資料庫。

