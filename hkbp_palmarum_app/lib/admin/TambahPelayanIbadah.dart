import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/admin/WartaJemaat.dart';
import 'package:hkbp_palmarum_app/admin/pelayanIbadah.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class TambahPelayanIbadah extends StatefulWidget {
  @override
  _TambahPelayanIbadahState createState() => _TambahPelayanIbadahState();
}

class _TambahPelayanIbadahState extends State<TambahPelayanIbadah> {
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

  Future<List<Map<String, dynamic>>> _fetchPelayanIbadah() async {
    final response = await http.get(Uri.parse('http://192.168.21.80:2007/pelayanan-ibadah-all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => {
        'id': e['id_pelayanan_ibadah'],
        'name': e['nama_pelayanan_ibadah'],
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  int? _selectedPelayanIbadah;
  List<Map<String, dynamic>> pelayanIbadah = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _fetchJadwalIbadah().then((data) {
      setState(() {
        namaMinggu = data;
      });
    }).catchError((error) {
      print('Error fetching data: $error');
      // Handle error
    });

    _fetchPelayanIbadah().then((data) {
      setState(() {
        pelayanIbadah = data;
      });
    }).catchError((error) {
      print('Error fetching data: $error');
      // Handle error
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _fetchJadwalIbadah() async {
    final response = await http.get(Uri.parse('http://192.168.21.80:2007/jadwal-ibadah'));

    if (response.statusCode == 200) {
      // Jika request berhasil, parse response body ke dalam List<Map<String, dynamic>>
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => {
        'id': e['id_jadwal_ibadah'],
        'name': e['tgl_ibadah'],
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  int? _selectedNamaMinggu;

  List<Map<String, dynamic>> namaMinggu = [];

  int? _nameSunday;

  Future<void> _createWarta(String wartaText) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.21.80:2007/warta/create'),
        headers: {
          'Content-Type': 'application/json', // Tambahkan header Content-Type
        },
        body: jsonEncode({
          'warta': wartaText,
        }),
      );

      if (response.statusCode == 200) {
        print('Warta successfully created');
        var snackBar =  SnackBar(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 240), // Menempatkan snackbar di atas layar
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Berhasil",
            message: "Berhasil Membuat Jadwal Ibadah",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WartaJemaat()),
        );
        // Lakukan navigasi atau tindakan lain setelah berhasil menambahkan warta
      } else {
        var snackBar =  SnackBar(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 155), // Menempatkan snackbar di atas layar
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Gagal",
            message: "Gagal Membuat Jadwal Ibadah",
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        throw Exception('Failed to create jadwal');
      }
    } catch (e) {
      print('Error creating warta: $e');
      // Handle error
    }
  }


  Future<void> _createPelayanIbadah(int idJadwal, int idPelayanan, String keterangan) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.21.80:2007/pelayan-ibadah/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_jadwal_ibadah': idJadwal,
          'id_pelayanan_ibadah': idPelayanan,
          'keterangan': keterangan,
        }),
      );

      if (response.statusCode == 200) {
        print('Pelayan Ibadah successfully created');
        var snackBar =  SnackBar(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 240), // Menempatkan snackbar di atas layar
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Berhasil",
            message: "Berhasil Membuat Pelayan Ibadah",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PelayanIbadah()),
        );
      } else {
        throw Exception('Failed to create pelayan ibadah');
      }
    } catch (e) {
      print('Error creating pelayan ibadah: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create pelayan ibadah'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
                            child: Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Icon(
                                    Icons.sort,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                );
                              },
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
                            "Tambah Pelayan Ibadah",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tambah Pelayan Ibadah",
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
                            labelText: 'Pilih Jadwal Ibadah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          value: _selectedNamaMinggu,
                          items: namaMinggu.map((jadwal) {
                            return DropdownMenuItem<int>(
                              value: jadwal['id'],
                              child: Text(jadwal['name']),
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
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: 'Pilih Pelayan Ibadah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          value: _selectedPelayanIbadah,
                          items: pelayanIbadah.map((pelayan) {
                            return DropdownMenuItem<int>(
                              value: pelayan['id'],
                              child: Text(pelayan['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedPelayanIbadah = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                        child: TextFormField(
                          controller: _controller,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Keterangan Ibadah',
                            hintText: 'Isi Keterangan Ibadah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          String wartaText = _controller.text.trim();
                          print('Warta Text: $wartaText');
                          if (_selectedNamaMinggu != null &&
                              _selectedPelayanIbadah != null &&
                              _controller.text.isNotEmpty) {
                            _createPelayanIbadah(
                              _selectedNamaMinggu!,
                              _selectedPelayanIbadah!,
                              _controller.text,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Harap lengkapi semua informasi'),
                              ),
                            );
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
      drawer: DrawerWidget(),
    );
  }
}
