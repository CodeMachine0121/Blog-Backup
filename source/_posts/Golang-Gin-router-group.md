---
title: 'Golang/Gin: router group'
tags: Golang/Gin
abbrlink: 2761fa2d
date: 2024-09-16 00:44:53
---

Hi all, for this article, I will keep note of how to use router group in Gin.
## What is Router Group
Router Group is a function to extract routers for each group.
For example, if there are 2 features of the API, we can use Router Group to separate routers to another file and split the routers by features.
<!--more-->
## Code
### main.go
```go
package main

import (
	"first-gin/service/routers"
	"github.com/gin-gonic/gin"
)

func main() {

	router := gin.Default()

	routerGroup := router.Group("/v1")
	routers.AddRouters(routerGroup)

	router.Run(":8080")
}
```
### routers/UserRouters.go
```go
package routers

import (
	"first-gin/service"
	"github.com/gin-gonic/gin"
)

func AddRouters(r *gin.RouterGroup) {

	user := r.Group("/users")

	user.GET("", service.FetchAll)
	user.POST("", service.Insert)
	user.DELETE("/:id", service.Delete)
}
```
## Explanation
1. We delete routing we'd added before and create a variable for the router group called `routerGroup`.
2. We call the `AddRouters` function from the `routers` package and pass the `routerGroup` as a parameter.
3. We add a new file called `UserRouters.go` in the `routers` package and add some routing config in the function `AddRouters`.

