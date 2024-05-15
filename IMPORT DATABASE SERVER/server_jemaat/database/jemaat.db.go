package database

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	"server-palmarum/model"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
)

const (
	DBUsername = "root"
	DBPassword = ""
	DBHost     = "localhost"
	DBPort     = "3306"
	DBName     = "server_jemaat"
)

func OpenDBConnection() (*sql.DB, error) {
	dataSourceName := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", DBUsername, DBPassword, DBHost, DBPort, DBName)
	db, err := sql.Open("mysql", dataSourceName)
	if err != nil {
		return nil, err
	}

	// Tes koneksi ke database
	err = db.Ping()
	if err != nil {
		return nil, err
	}

	return db, nil
}

func GetJemaatBerulangTahun() ([]model.Jemaat, error) {
	var ulangtahun []model.Jemaat

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/server_jemaat")
	if err != nil {
		return ulangtahun, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetJemaatBirthdayToday()")
	if err != nil {
		return ulangtahun, err
	}
	defer rows.Close()

	for rows.Next() {
		var k model.Jemaat
		err := rows.Scan(&k.IDJemaat, &k.NamaDepan, &k.NamaBelakang, &k.TGLLahir, &k.FotoJemaat)
		if err != nil {
			return ulangtahun, err
		}

		ulangtahun = append(ulangtahun, k)
	}

	return ulangtahun, nil
}

func UpdateJemaatProfileProcedure(jemaatID int, namaDepan, namaBelakang, tempatLahir, noHP, alamat, email string) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL UpdateJemaatProfileProcedure(?, ?, ?, ?, ?, ?, ?)", jemaatID, namaDepan, namaBelakang, tempatLahir, noHP, alamat, email)
	if err != nil {
		return err
	}

	return nil
}

func UpdateJemaat(jemaatID string, u model.Jemaat) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	stmt, err := db.Prepare("UPDATE jemaat SET nama_depan=?, nama_belakang=?, tgl_lahir = ?, jenis_kelamin=?, alamat=?, id_bidang_pendidikan=?, id_pekerjaan=?, no_hp=?, isBaptis=?, isMenikah=?, isMeninggal=?, keterangan=? ,email=? ,password=? ,id_pendidikan = ? ,id_hub_keluarga = ? ,bidang_pendidikan_lainnya = ? ,nama_pekerjaan_lainnya = ? ,id_kecamatan = ? ,gol_darah = ? ,isSidi = ? WHERE id_jemaat=?")
	if err != nil {
		return err
	}
	defer stmt.Close()

	_, err = stmt.Exec(u.NamaDepan, u.NamaBelakang, u.TGLLahir, u.JenisKelamin, u.Alamat, u.IDBidangPendidikan, u.IDPekerjaan, u.NoTelepon, u.IsBaptis, u.IsMenikah, u.IsMeninggal, u.Keterangan, u.Email, u.Password, u.IDPendidikan, u.IDHubKeluarga, u.BidangPendidikanLainnya, u.NamaPekerjaanLainnya, u.IDKecamatan, u.GolDarah, u.IsSidi, jemaatID)
	if err != nil {
		return err
	}

	return nil
}

func UpdateJemaatImageURL(jemaatID, imageURL string) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	// Statement SQL untuk melakukan update URL gambar jemaat
	query := fmt.Sprintf("UPDATE jemaat SET foto_jemaat='%s' WHERE id_jemaat='%s'", imageURL, jemaatID)

	_, err = db.Exec(query)
	if err != nil {
		return err
	}

	return nil
}

// Tambahkan fungsi Login di file database (jemaat.db.go)
// jemaatDB
func Login(email, password string) (model.Jemaat, error) {
	var jemaat model.Jemaat

	// Buat koneksi ke database
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return jemaat, err
	}
	defer db.Close()

	// Prepare statement untuk memanggil stored procedure
	stmt, err := db.Prepare("CALL LoginProcedure(?, ?, @jemaatID, @rolejemaat, @jemaatNamaDepan, @jemaatNamaBelakang, @jemaatEmail, @jemaatPassword, @jemaatGelarDepan, @jemaatGelarBelakang, @jemaatTempatLahir, @jemaatJenisKelamin, @jemaatIDHubKeluarga, @jemaatIDStatusPernikahan, @jemaatIDStatusAmaIna, @jemaatIDStatusAnak, @jemaatIDPendidikan, @jemaatIDBidangPendidikan, @jemaatBidangPendidikanLainnya, @jemaatIDPekerjaan, @jemaatNamaPekerjaanLainnya, @jemaatGolDarah, @jemaatAlamat, @jemaatIsSidi, @jemaatIDKecamatan, @jemaatNoTelepon, @jemaatNoHP, @jemaatFotoJemaat, @jemaatKeterangan, @jemaatIsBaptis, @jemaatIsMenikah, @jemaatIsMeninggal, @jemaatIsRPP, @jemaatCreateAt, @jemaatUpdateAt, @jemaatIsDeleted)")
	if err != nil {
		return jemaat, err
	}
	defer stmt.Close()

	// Eksekusi stored procedure
	_, err = stmt.Exec(email, password)
	if err != nil {
		return jemaat, err
	}

	// Ambil nilai-nilai output dari stored procedure
	err = db.QueryRow("SELECT @jemaatID, @rolejemaat ,@jemaatNamaDepan, @jemaatNamaBelakang, @jemaatEmail, @jemaatPassword, @jemaatGelarDepan, @jemaatGelarBelakang, @jemaatTempatLahir, @jemaatJenisKelamin, @jemaatIDHubKeluarga, @jemaatIDStatusPernikahan, @jemaatIDStatusAmaIna, @jemaatIDStatusAnak, @jemaatIDPendidikan, @jemaatIDBidangPendidikan, @jemaatBidangPendidikanLainnya, @jemaatIDPekerjaan, @jemaatNamaPekerjaanLainnya, @jemaatGolDarah, @jemaatAlamat, @jemaatIsSidi, @jemaatIDKecamatan, @jemaatNoTelepon, @jemaatNoHP, @jemaatFotoJemaat, @jemaatKeterangan, @jemaatIsBaptis, @jemaatIsMenikah, @jemaatIsMeninggal, @jemaatIsRPP, @jemaatCreateAt, @jemaatUpdateAt, @jemaatIsDeleted").Scan(&jemaat.IDJemaat, &jemaat.RoleJemaat, &jemaat.NamaDepan, &jemaat.NamaBelakang, &jemaat.Email, &jemaat.Password, &jemaat.GelarDepan, &jemaat.GelarBelakang, &jemaat.TempatLahir, &jemaat.JenisKelamin, &jemaat.IDHubKeluarga, &jemaat.IDStatusPernikahan, &jemaat.IDStatusAmaIna, &jemaat.IDStatusAnak, &jemaat.IDPendidikan, &jemaat.IDBidangPendidikan, &jemaat.BidangPendidikanLainnya, &jemaat.IDPekerjaan, &jemaat.NamaPekerjaanLainnya, &jemaat.GolDarah, &jemaat.Alamat, &jemaat.IsSidi, &jemaat.IDKecamatan, &jemaat.NoTelepon, &jemaat.NoTelepon, &jemaat.FotoJemaat, &jemaat.Keterangan, &jemaat.IsBaptis, &jemaat.IsMenikah, &jemaat.IsMeninggal, &jemaat.IsRPP, &jemaat.CreateAt, &jemaat.UpdateAt, &jemaat.IsDeleted)
	if err != nil {
		if err == sql.ErrNoRows {
			return jemaat, errors.New("invalid credentials")
		}
		return jemaat, err
	}

	return jemaat, nil
}

// Fungsi untuk mendapatkan nama file gambar dari database berdasarkan ID jemaat
func GetImageNameFromDatabase(jemaatID string) string {
	// Lakukan koneksi ke database
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		log.Println("Error connecting to the database:", err)
		return ""
	}
	defer db.Close()

	// Lakukan query ke database untuk mendapatkan nama file gambar berdasarkan jemaatID
	var imageName string
	err = db.QueryRow("SELECT foto_jemaat FROM jemaat WHERE id_jemaat = ?", jemaatID).Scan(&imageName)
	if err != nil {
		log.Println("Error querying the database:", err)
		return ""
	}

	// Jika tidak ada gambar yang ditemukan dalam database, kembalikan string kosong
	if imageName == "" {
		log.Println("Image not found in the database")
		return ""
	}

	return imageName
}

func GetJemaat(jemaatId int) (model.Jemaat, error) {
	var jemaat model.Jemaat

	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return jemaat, err
	}
	defer db.Close()

	stmt, err := db.Prepare("CALL GetJemaat(?)")
	if err != nil {
		return jemaat, err
	}
	defer stmt.Close()

	row := stmt.QueryRow(jemaatId)
	var pendidikanString string
	err = row.Scan(&jemaat.IDJemaat, &jemaat.NamaDepan, &jemaat.NamaBelakang, &jemaat.JenisKelamin, &jemaat.Alamat, &jemaat.IDBidangPendidikan, &jemaat.IDPekerjaan, &jemaat.NoTelepon, &jemaat.IsBaptis, &jemaat.IsSidi, &jemaat.IsMenikah, &jemaat.IsMeninggal, &jemaat.Keterangan, &pendidikanString)
	if err != nil {
		return jemaat, err
	}

	// Konversi nilai pendidikan string ke integer
	jemaat.IDPendidikan, err = strconv.Atoi(pendidikanString)
	if err != nil {
		// Penanganan nilai default pendidikan
		if pendidikanString == "Pilih Pendidikan Anda" {
			// Atur nilai ID pendidikan ke nilai default yang sesuai
			jemaat.IDPendidikan = 0 // atau nilai default yang sesuai
		} else {
			return jemaat, err // Teruskan error jika tidak ada nilai default
		}
	}

	return jemaat, nil
}
