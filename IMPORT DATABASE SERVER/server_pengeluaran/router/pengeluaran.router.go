package router

import (
	"server_pengeluaran/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	Pengeluaran := controller.NewPengeluaranController()

	// Endpoint untuk membuat jemaat baru
	// r.POST("/jemaat", jemaatController.CreateJemaat)

	// Endpoint untuk create Kegiatan
	r.POST("/pengeluaran/create", Pengeluaran.CreatePengeluaran)

	// Endpoint untuk mengambil data Pengeluaran
	r.GET("/pengeluaran", Pengeluaran.GetPengeluaranData)

	// Endpoint untuk mengedit data Pengeluaran
	r.PUT("/pengeluaran", Pengeluaran.UpdatePengeluaran)

	// Endpoint untuk mengambil data Pengeluaran berdasarkan ID
	r.GET("/pengeluaran/:id_pengeluaran", Pengeluaran.GetPengeluaranByID)

	// Endpoint untuk image pemasukan berdasarkan ID
	r.GET("/pengeluaran/image/:id_pengeluaran", Pengeluaran.GetImagePengeluaranPengeluaran)
	return r
}
