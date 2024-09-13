---
title: 'Golang/Gin: (CRUD) Delete Data'
tags: Golang/Gin
abbrlink: 302493fc
date: 2024-09-13 09:18:39
---
Hi all, for this article, I'll show how to delete data using Gin
## Purpose
1. New endpoint to delete data.
2. Add a function in the service layer to handle the request.
3. Extract the ID from the request parameter(Restful).
4. Remove the data from the list.
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