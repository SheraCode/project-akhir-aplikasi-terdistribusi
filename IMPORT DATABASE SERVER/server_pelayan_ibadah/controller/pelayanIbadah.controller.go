package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"

	"github.com/gin-gonic/gin"
)

type PelayanIbadahController struct{}

func NewPelayanIbadahController() *PelayanIbadahController {
	return &PelayanIbadahController{}
}

func (jc *PelayanIbadahController) GetAllPelayan(c *gin.Context) {
	pelayanIbadah, err := database.GetPelayanIbadah()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanIbadah)
}

func (kc *PelayanIbadahController) AddPelayanIbadah(c *gin.Context) {
	var pelayan model.PelayanIbadah
	err := c.BindJSON(&pelayan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data pelayan ibadah di database
	err = database.CreatePelayanIbadah(pelayan.IDPelayan, pelayan.IDPelayanan_IBADAH, pelayan.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data pelayan ibadah created successfully!"})
}
