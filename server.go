package main

import (
	"fmt"
	"github.com/labstack/echo"
	"net/http"
	"os"
	"strings"
)

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		for _, e := range os.Environ() {
			pair := strings.Split(e, "=")
			fmt.Println(pair[0])
		}
		return c.String(http.StatusOK, os.Getenv("HOSTNAME"))
	})
	e.Logger.Fatal(e.Start(":1323"))
}
