---
title: 'Golang/Gin: Hello World'
tags: 'Golang/Gin'
abbrlink: 34e63b71
date: 2024-09-11 23:55:44
---

## Why

I think it's a good idea to start with a Gin a web framework for Golang to understand advanced usage of Golang. So I decided to learn Gin day by day. (it's a unstable plan XD)

## What is Gin

Let's see how Copilot explain Gin.
<!--more-->
>> Gin is a web framework written in Go (Golang). It's known for its lightweight nature, high performance, and low memory footprint. Here are the main features of Gin:
>>
>> 1. Speed: Gin uses a custom version of HttpRouter, which makes it extremely fast.
>> 2. Middleware support: Gin allows the use of middleware in the request processing pipeline, making it easy to implement features like logging and error handling.
>> 3. Error management: Gin provides a convenient mechanism for error handling.
>> 4. JSON validation: It has built-in JSON validation functionality, making it easy to handle JSON data.
>> 5. Route grouping: Gin supports grouping routes, which is useful for managing APIs in large applications.
>> 6. Rendering: It supports rendering XML, JSON, and HTML.

Gin is excellent for building API services and can also be used for developing full-stack web applications. Its design philosophy is to keep the core simple while allowing functionality to be added through middleware and extensions. For Go web developers who need high performance and flexibility, Gin is an excellent choice.

## Project Setup

1. Create a new directory for your project and navigate into it.
2. Initialize a new Go module.

    ```bash
        go mod init hello-gin
    ```

3. Install Gin.

    ```bash
        go get -u github.com/gin-gonic/gin
    ```

4. Create a main.go file.

    ```go
        package main

        import "github.com/gin-gonic/gin"

        func main() {
            r := gin.Default()
            r.GET("/hello-world", func(c *gin.Context) {
                c.JSON(http.StatusOK, gin.H{
                    "message": "Hello World",
                })
            })
            r.Run()
        }
    ```

5. Use Terminal to Run the application.

    ```bash
        go run main.go
    ```

## Explanation code

`import`
we import gin package from Gin. maybe can refer this repository [Gin](https://github.com/gin-gonic/gin).

`func main()`
This is the entry point of the application.

`r := gin.Default()`
This creates a new Gin router with default settings.

`r.GET("/", func(c *gin.Context) { ... })`
This sets up a route for GET requests at the root URL ("/"). When a GET request is made to this URL, the function passed as the second argument is executed. It sends a JSON response with a status code of 200 and a message "Hello World".

`r.Run()`
This starts the HTTP server and listens for incoming requests on port 8080 by default.
we can change the port by passing a parameter to the `r.Run()` function, like this: `r.Run(":3000")`.

## E2E Test

we can use `curl` to test the application.

```bash
curl http://localhost:8080
```

we should see the response:

```json
{"message":"Hello World"}
```
