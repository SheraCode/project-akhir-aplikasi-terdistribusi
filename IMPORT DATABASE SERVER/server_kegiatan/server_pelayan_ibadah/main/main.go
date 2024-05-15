package main

import (
	"log"
	"net/http"
	"server_pelayan_ibadah/router"
)

func main() {
	Auth := router.SetupRouter()
	log.Fatal(http.ListenAndServe(":2005", Auth))
}
