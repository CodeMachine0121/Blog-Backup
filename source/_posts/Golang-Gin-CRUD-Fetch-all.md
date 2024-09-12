---
title: 'Golang/Gin: (CRUD) Fetch all'
tags: Golang/Gin
abbrlink: 9a6a850b
date: 2024-09-12 15:02:47
---

This is a simple CRUD example using Gin to fetch all data.

## Purpose

1. Hard code a list of user data.
2. Create a GET endpoint to fetch all data.
3. Extract service layer to handle the requests.
<!--more-->

## Code

### main.go

```go
package main

import (
  "first-gin/service"
  "github.com/gin-gonic/gin"
)

func main() {

    router := gin.Default()

    router.GET("/users", service.FetchAll)

    router.Run(":8080")
}
```

### service/user.go

```go
package service

import (
 "first-gin/models"
 "github.com/gin-gonic/gin"
)

var useList = []models.User{
 {ID: 1, Name: "John", Email: "john@mail"},
 {ID: 2, Name: "Doe", Email: "doe@mail"},
}

func FetchAll(c *gin.Context) {

 c.JSON(200, gin.H{
  "message": useList,
 })
}
```

### models/user.go

```go
package models

type User struct {
 ID    int    `json:"id"`
 Name  string `json:"name"`
 Email string `json:"email"`
}
```

## Explanation

1. Create a routing for `/users` endpoint.
2. Create a service layer to handle the requests and extract the logic from the main.go.
   1. Create a variable to store the user data.
   2. Create a function to fetch all data.
   3. Return the data to the client.
3. Create a models for the user data.
   1. Use json tag to map the data to the struct.

## E2E Test

```bash
curl http://localhost:8080/users
```

we should see the response:

```json
{
  "message": [
    {
      "id": 1,
      "name": "John",
      "email": "john@mail"
    },
    {
      "id": 2,
      "name": "Doe",
      "email": "doe@mail"
    }
  ]
}
```
