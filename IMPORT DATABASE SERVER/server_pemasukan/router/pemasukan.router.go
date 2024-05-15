package router

import (
	"server_pemasukan/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	Pemasukan := controller.NewPemasukanController()

	// Endpoint untuk membuat jemaat baru
	// r.POST("/jemaat", jemaatController.CreateJemaat)

	// Endpoint untuk create Kegiatan
	r.POST("/pemasukan/create", Pemasukan.CreatePemasukan)

	// Endpoint untuk mengambil data Pemasukan
	r.GET("/pemasukan", Pemasukan.GetPemasukanData)

	// Endpoint untuk mengedit data Pemasukan
	r.PUT("/pemasukan", Pemasukan.UpdatePemasukan)

	// Endpoint untuk mengambil data Pengeluaran berdasarkan ID
	r.GET("/pemasukan/:id_pemasukan", Pemasukan.GetPemasukanByIDData)

	// Endpoint untuk image pemasukan berdasarkan ID
	r.GET("/pemasukan/image/:id_pemasukan", Pemasukan.GetImagePemasukanPemasukan)

	return r
}
