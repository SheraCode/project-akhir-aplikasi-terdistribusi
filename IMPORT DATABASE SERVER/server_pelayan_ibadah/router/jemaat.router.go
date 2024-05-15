package router

import (
	"server-palmarum/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	PelayanIbadahController := controller.NewPelayanIbadahController()
	PelayananIbadahALLController := controller.NewPelayanGerejaALLController()
	JadwalIbadah := controller.NewJadwalIbadahController()

	// Endpoint untuk membuat jemaat baru
	// r.POST("/jemaat", jemaatController.CreateJemaat)

	// Endpoint untuk mengambil Data Pelayan Ibadah
	r.GET("/pelayan-ibadah", PelayanIbadahController.GetAllPelayan)

	// Endpoint untuk mengambil semua data Pelayanan Ibadah
	r.GET("/pelayanan-ibadah-all", PelayananIbadahALLController.GetDataPelayanGereja)

	// Endpoint untuk mengedit data pelayanan ibadah dengan ID tertentu
	r.PUT("/pelayanan_ibadah/:id", PelayananIbadahALLController.EditDataPelayanGereja)

	// Endpoint untuk menampilkan semua data Jadwal Ibadah
	r.GET("/jadwal-ibadah", JadwalIbadah.GetAllJadwalIbadah)

	// Endpoint untuk mengedit data Jadwal Ibadah BYID
	r.PUT("/jadwal-ibadah/:id", JadwalIbadah.EditDataJadwalIbadah)

	// Endpoint untuk create data pelayan_ibadah
	r.POST("/pelayan-ibadah/create", PelayanIbadahController.AddPelayanIbadah)

	// Endpoint untuk create data pelayanan ibadah
	r.POST("/pelayanan-ibadah/create", PelayananIbadahALLController.CreatePelayanIbadah)

	// Endpoint untuk jadwal ibadah create
	r.POST("/jadwal-ibadah/create", JadwalIbadah.AddJadwalIbadah)

	// Endpoint untuk GetJadwal-IbadahBYID
	r.GET("/jadwal-ibadah/:id", JadwalIbadah.GetJadwalIbadahByIDHandler)

	// Endpoint untuk GetNamaPelayan
	r.GET("/pelayanan-ibadah/:id", PelayananIbadahALLController.GetPelayananGerejaByIDHandler)

	return r
}
