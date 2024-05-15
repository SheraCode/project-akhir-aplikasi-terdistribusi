package main

import (
	"log"
	"net/http"
	"server-palmarum/router"
)

func main() {
	Auth := router.SetupRouter()
	log.Fatal(http.ListenAndServe(":2007", Auth))
}
