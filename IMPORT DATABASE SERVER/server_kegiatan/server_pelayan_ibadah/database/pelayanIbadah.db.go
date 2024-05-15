package database

import (
	"database/sql"
	"server_pelayan_ibadah/model"

	_ "github.com/go-sql-driver/mysql"
)

func GetPelayanIbadah() ([]model.PelayanIbadah, error) {
	var pelayanibadah []model.PelayanIbadah

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/server_pelayan_ibadah1")
	if err != nil {
		return pelayanibadah, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetPelayanIbadahData()")
	if err != nil {
		return pelayanibadah, err
	}
	defer rows.Close()

	for rows.Next() {
		var pl model.PelayanIbadah
		err := rows.Scan(&pl.IDPelayanan_IBADAH, &pl.IDPelayan, &pl.NamaPelayanan, &pl.Keterangan, &pl.SesiIbadah, &pl.TanggalIbadah)
		if err != nil {
			return pelayanibadah, err
		}

		pelayanibadah = append(pelayanibadah, pl)
	}

	return pelayanibadah, nil
}

func CreatePelayanIbadah(p_id_jadwal_ibadah int, p_id_pelayanan_ibadah int, p_keterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/server_pelayan_ibadah1")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreatePelayanIbadahData(?, ?, ?)", p_id_jadwal_ibadah, p_id_pelayanan_ibadah, p_keterangan)
	if err != nil {
		return err
	}

	return nil
}
