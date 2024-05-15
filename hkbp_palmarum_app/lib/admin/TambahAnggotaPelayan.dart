import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/admin/PelayanIbadahKebaktian.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class TambahAnggotaPelayan extends StatefulWidget {
  @override
  _TambahAnggotaPelayanState createState() => _TambahAnggotaPelayanState();
}

class _TambahAnggotaPelayanState extends State<TambahAnggotaPelayan> {
  late TextEditingController _controllerNama;
  late TextEditingController _controllerKeterangan;
  var height, width;

  @override
  void initState() {
    super.initState();
    _controllerNama = TextEditingController();
    _controllerKeterangan = TextEditingController();
  }

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerKeterangan.dispose();
    super.dispose();
  }

  Future<void> _createPelayananIbadah(String namaPelayanan, String keterangan) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.21.80:2007/pelayanan-ibadah/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama_pelayanan_ibadah': namaPelayanan,
          'keterangan': keterangan,
        }),
      );

      if (response.statusCode == 200) {
        print('Pelayanan Ibadah berhasil dibuat');
        var snackBar =  SnackBar(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 225), // Menempatkan snackbar di atas layar
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Success",
            message: "Berhasil Membuat Pelayan Kebaktian",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PelayanKebaktian()),
        );
        // Navigasi atau tindakan lain setelah berhasil membuat pelayanan ibadah
      } else {
        print('Gagal membuat pelayanan ibadah');
        var snackBar = SnackBar(
          content: Text('Gagal membuat pelayanan ibadah'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print('Error creating pelayanan ibadah: $e');
      var snackBar = SnackBar(
        content: Text('Terjadi kesalahan'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                              "Tambah Pelayan Kebaktian",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Tambah Pelayan Kebaktian",
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
                          child: TextFormField(
                            controller: _controllerNama,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: 'Nama Pelayanan',
                              hintText: 'Nama Pelayanan Ibadah',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                          child: TextFormField(
                            controller: _controllerKeterangan,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: 'Keterangan',
                              hintText: 'Keterangan Pelayanan Ibadah',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            String namaPelayanan = _controllerNama.text.trim();
                            String keterangan = _controllerKeterangan.text.trim();
                            if (namaPelayanan.isNotEmpty && keterangan.isNotEmpty) {
                              _createPelayananIbadah(namaPelayanan, keterangan);
                            } else {
                              var snackBar = SnackBar(
                                content: Text('Nama Pelayanan dan Keterangan harus diisi'),
                                backgroundColor: Colors.red,
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
    );
  }
}
