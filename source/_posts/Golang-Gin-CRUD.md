---
title: 'Golang/Gin: CRUD'
abbrlink: c0077237
date: 2024-09-14 19:16:38
tags: Golang/Gin
---
This is a simple CRUD example with using Gin.
<!--more-->
# Get

## Purpose

1. Hard code a list of user data.
2. Create a GET endpoint to fetch all data.
3. Extract service layer to handle the requests.

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

# Post

## Purpose

1. Create a POST endpoint to insert data.
2. Add function in the service layer to handle the request.
3. Parse the data from request body into model type.
4. Add the data to the list.
5. Return the list.

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

    router.POST("", service.Insert)

    router.Run(":8080")
}
```

### service/user.go

```go
func Insert(c *gin.Context) {

 var user models.User
 c.BindJSON(&user)

 useList = append(useList, user)
 c.JSON(200, gin.H{
  "message": useList,
 })
}
```

## Explanation

1. first, we added a router for the POST request.
2. In the service layer, we added a function to handle the POST request.
    1. Declared a null user model.
    2. Use `BindJSON` to bind the request body to the user model.
    3. Append the parsed data to the list.
    4. Return the list as a response.

## E2E Testing

we cat use curl to test the POST request.

```bash
curl -X POST http://localhost:8080 -d '{"ID": 3, "Name": "Jane", "Email": "jane@mail"}'
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
    },
    {
      "id": 3,
      "name": "Jane",
      "email": "jane@mail"
    }
  ]
}
```

# Delete

## Purpose

1. New endpoint to delete data.
2. Add a function in the service layer to handle the request.
3. Extract the ID from the request parameter(Restful).
4. Remove the data from the list.
5. Return the list.

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
 router.POST("", service.Insert)
 // define the route with parameter
 router.DELETE("user/:id", service.Delete)

 router.Run(":8080")
}
```

### service/user.go

```go
func Delete(context *gin.Context) {
 // get id from routing like restful api and to int
 id, _ := strconv.Atoi(context.Param("id"))

 useList = Filter(useList, func(user models.User) bool {
  return user.ID != id
 })

 context.JSON(200, gin.H{
  "message": useList,
 })
}

func Filter(list []models.User, predicate func(user models.User) bool) []models.User {
 var result []models.User
 for _, user := range list {
  if predicate(user) {
   result = append(result, user)
  }
 }
 return result
}
```

## Explanation

1. Added a new route for the DELETE request in main.go.
2. In the service layer, added a function to handle the DELETE request.
    1. Extract the ID from the request parameter.
    2. New a function `Filter` and make it receive a func as a parameter
    3. For the predicate function, we check if the user ID is not equal to the ID we want to delete.
    4. Return the list as a response.
3. return the list as a response.
