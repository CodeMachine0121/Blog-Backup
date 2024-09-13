---
title: 'Golang/Gin: (CRUD) Insert Data'
tags: Golang/Gin
abbrlink: db734ca8
date: 2024-09-13 01:44:26
---

Hi all, this article is expected to see how post request works with Gin.
I'll show a simple demo for handling the POST request.

## Purpose
1. Create a POST endpoint to insert data.
2. Add function in the service layer to handle the request.
3. Parse the data from request body into model type.
4. Add the data to the list.
5. Return the list.
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