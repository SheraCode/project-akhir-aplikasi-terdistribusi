import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/admin/JadwalIbadah.dart';
import 'package:hkbp_palmarum_app/admin/WartaJemaat.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class TambahJadwalIbadah extends StatefulWidget {
  @override
  _TambahJadwalIbadahState createState() => _TambahJadwalIbadahState();
}

class _TambahJadwalIbadahState extends State<TambahJadwalIbadah> {
  late TextEditingController _sesiIbadahController;
  late TextEditingController _keteranganIbadahController;
  late TextEditingController _controller;
  var height, width;
  TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }



  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _sesiIbadahController = TextEditingController();
    _keteranganIbadahController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _sesiIbadahController.dispose();
    _keteranganIbadahController.dispose();
    super.dispose();
  }

  int? _selectedNamaMinggu;

  List<Map<String, dynamic>> namaMinggu = [
    {"id": 1, "name": "Advent I – IV"},
    {"id": 2, "name": "Natal"},
    {"id": 3, "name": "Setelah Tahun Baru"},
    {"id": 4, "name": "I – IV Setelah Epifani / Hapapatar"},
    {"id": 5, "name": "Septuagesima / Sexagesima"},
    {"id": 6, "name": "Estomihi"},
    {"id": 7, "name": "Invocavit"},
    {"id": 8, "name": "Reminiscere"},
    {"id": 9, "name": "Okuli"},
    {"id": 10, "name": "Letare"},
    {"id": 11, "name": "Judika"},
    {"id": 12, "name": "Palmarum (Maremare)"},
    {"id": 13, "name": "Paskah Pertama / Paskah"},
    {"id": 14, "name": "Quasimodo Geniti"},
    {"id": 15, "name": "Miserekordias Domini"},
    {"id": 16, "name": "Jubilate"},
    {"id": 17, "name": "Kantate"},
    {"id": 18, "name": "Rogate"},
    {"id": 19, "name": "Exaudi"},
    {"id": 20, "name": "Pentakosta"},
    {"id": 21, "name": "Trinitatis"},
    {"id": 22, "name": "I – XXIV Setelah Trinitatis"},
  ];


  int? _nameSunday;

  Future<void> _createWarta(String sesiIbadahText, String keteranganIbadahText) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.21.80:2007/jadwal-ibadah/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_jenis_minggu': _selectedNamaMinggu,
          'tgl_ibadah': _dateController.text,
          'sesi_ibadah': sesiIbadahText,
          'keterangan': keteranganIbadahText,
        }),
      );

      if (response.statusCode == 200) {
        print('Jadwal Ibadah berhasil dibuat');
        var snackBar =  SnackBar(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 225), // Menempatkan snackbar di atas layar
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Success",
            message: "Berhasil Membuat Jadwal Ibadah",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JadwalIbadah()),
        );
        // Tambahkan kode untuk menampilkan pesan sukses
      } else {
        print('Gagal membuat jadwal ibadah');
        // Tambahkan kode untuk menampilkan pesan gagal
      }
    } catch (e) {
      print('Error creating warta: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.indigo,
            child: Column(
              children: [
                Container(
                  height: height * 0.22,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: InkWell(
                                onTap: () {
                                  // Handle drawer tap
                                },
                                child: Icon(
                                  Icons.sort,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tambah Jadwal Ibadah",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Tambah Jadwal Ibadah",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white54,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'Pilih Nama Minggu',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            value: _selectedNamaMinggu,
                            items: namaMinggu.map((minggu) {
                              return DropdownMenuItem<int>(
                                value: minggu['id'],
                                child: Text(minggu['name']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedNamaMinggu = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                          child: TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context); // Panggil method _selectDate saat input tanggal diklik
                            },
                            decoration: InputDecoration(
                              labelText: 'Tanggal',
                              hintText: 'Pilih Tanggal',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _sesiIbadahController,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Sesi Ibadah',
                            hintText: 'Isi Sesi Ibadah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _keteranganIbadahController,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Keterangan Ibadah',
                            hintText: 'Isi Keterangan Ibadah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            String sesiIbadahText = _sesiIbadahController.text.trim();
                            String keteranganIbadahText = _keteranganIbadahController.text.trim();

                            if (sesiIbadahText.isNotEmpty && keteranganIbadahText.isNotEmpty) {
                              _createWarta(sesiIbadahText, keteranganIbadahText);
                            } else {
                              var snackBar = SnackBar(
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 155),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: "Gagal",
                                  message: "Sesi Ibadah dan Keterangan Ibadah harus diisi",
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  'Tambah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.info_outline, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  'Batal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
