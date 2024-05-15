package model

type WaktuKegiatan struct {
	IDWaktuKegiatan int    `json:"id_waktu_kegiatan"`
	IDJenisKegiatan int    `json:"id_jenis_kegiatan"`
	IDGereja        int    `json:"id_gereja"`
	NamaKegiatan    string `json:"nama_kegiatan"`
	LokasiKegiatan  string `json:"lokasi_kegiatan"`
	WaktuKegiatan   string `json:"waktu_kegiatan"`
	KegiatanFoto    string `json:"foto_kegiatan"`
	Keterangan      string `json:"keterangan"`
}
