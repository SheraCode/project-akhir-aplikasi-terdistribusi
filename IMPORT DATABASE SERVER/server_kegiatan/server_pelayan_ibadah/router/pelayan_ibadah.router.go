package router

import (
	"server_pelayan_ibadah/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	PelayanIbadahController := controller.NewPelayanIbadahController()

	// Endpoint untuk mengambil Data Pelayan Ibadah
	r.GET("/pelayan-ibadah", PelayanIbadahController.GetAllPelayan)

	// Endpoint untuk create data pelayan_ibadah
	r.POST("/pelayan-ibadah/create", PelayanIbadahController.AddPelayanIbadah)

	return r
}
