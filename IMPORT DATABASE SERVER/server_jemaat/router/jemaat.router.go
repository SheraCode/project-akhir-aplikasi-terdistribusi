package router

import (
	"server-palmarum/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	jemaatController := controller.NewJemaatController()

	// Endpoint untuk membuat jemaat baru
	// r.POST("/jemaat", jemaatController.CreateJemaat)

	// Endpoint untuk memperbarui data jemaat dengan gambar
	r.PUT("/jemaat/:id_jemaat", jemaatController.UpdateJemaat)

	// Endpoint untuk memperbarui data jemaat di profil
	r.PUT("/jemaat/profil/:id_jemaat", jemaatController.UpdateJemaatProfil)

	// Endpoint untuk mendapatkan data jemaat berdasarkan id yang dikirimkan melalui raw body JSON
	r.POST("/jemaat", jemaatController.GetJemaat)

	// Endpoint untuk mengupdate gambar jemaat
	r.POST("/jemaat/:id_jemaat/image", jemaatController.UpdateJemaatImage)

	// Endpoint untuk mengambil gambar jemaat	
	r.GET("/jemaat/:id_jemaat/image", jemaatController.GetJemaatImage)

	r.POST("/jemaat/login", jemaatController.Login)

	return r
}
