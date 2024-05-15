package main

import (
	"log"
	"net/http"
	"server_pemasukan/router"
)

func main() {
	Auth := router.SetupRouter()
	log.Fatal(http.ListenAndServe(":2008", Auth))
}
