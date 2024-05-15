package router

import (
	"server_kegiatan/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	beritaController := controller.NewKegiatanController()

	// Endpoint untuk GetAllKegiatan
	r.GET("/berita", beritaController.GetAllKegiatan)

	// Endpoint untuk GetAllKegiatanByID
	r.GET("/berita/:id_waktu_kegiatan", beritaController.GetKegiatanByID)

	// Endpoint untuk GetAllKegiatanHome
	r.GET("/berita/home", beritaController.GetAllKegiatanUtama)

	// Endpoint untuk Create Kegiatan
	r.POST("/berita/create", beritaController.CreateKegiatan)

	// Endpoint untuk mengambil gambar kegiatan
	r.GET("/kegiatan/:id_waktu_kegiatan/image", beritaController.GetKegiatanImage)

	// Endpoint untuk mengambil semua gambar yang ada
	r.GET("/kegiatan/image", beritaController.GetKegiatanImageAll)

	// Endpoint untuk edit Berita
	r.PUT("/berita/:id_waktu_kegiatan", beritaController.UpdateKegiatan)

	

	return r
}
