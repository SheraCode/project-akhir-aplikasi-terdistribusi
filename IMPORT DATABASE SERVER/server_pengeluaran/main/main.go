package main

import (
	"log"
	"net/http"
	"server_pengeluaran/router"
)

func main() {
	Auth := router.SetupRouter()
	log.Fatal(http.ListenAndServe(":2009", Auth))
}
