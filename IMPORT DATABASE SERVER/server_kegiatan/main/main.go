package main

import (
	"log"
	"net/http"
	"server_kegiatan/router"
)

func main() {
	Auth := router.SetupRouter()
	log.Fatal(http.ListenAndServe(":2006", Auth))
}
