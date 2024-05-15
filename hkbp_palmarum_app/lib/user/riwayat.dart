import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/user/detailBaptis.dart';
import 'package:hkbp_palmarum_app/user/detailMarguru.dart';
import 'package:hkbp_palmarum_app/user/detailPernikahan.dart';
import 'package:hkbp_palmarum_app/user/home.dart';
import 'package:hkbp_palmarum_app/user/kegiatan.dart';
import 'package:hkbp_palmarum_app/user/profil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hkbp_palmarum_app/user/login.dart';
import 'package:hkbp_palmarum_app/user/register.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class riwayat extends StatefulWidget {
  @override
  _riwayatState createState() => _riwayatState();
}

List<String> titles = [
  'Pembaptisan David Silalahi',
  'Pernikahan Johannes Bastian Jasa Sipayung & Christia Otenia br Purba',
  'Marguru Pangeran Silaen',
  // Tambahkan judul lainnya sesuai jumlah gambar
];

List<Widget> pages = [
  // Sesuaikan dengan halaman yang ingin ditampilkan untuk setiap card
  detailbaptis(), // Contoh: halaman login
  detailPernikahan(), // Contoh: halaman register
  DetailSidi(), // Contoh: halaman admin
  // Tambahkan halaman lainnya sesuai kebutuhan
];

class _riwayatState extends State<riwayat> {
  void _launchMaps() async {
    // URL untuk tautan Google Maps yang ingin dibuka
    final url = 'https://maps.app.goo.gl/wjU1e8J66M8Jg1iS8';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Tidak dapat membuka Google Maps') ;
    }
  }


  // Daftar gambar untuk setiap card
  List<String> imagePaths = [
    'assets/userbaptis.jpg',
    'assets/userpernikahan.jpg',
    'assets/angkatsidi.jpeg',
    // Tambahkan path gambar lainnya di sini sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Box Decoration dengan Shadow
            Container(
              height: MediaQuery.of(context).size.height / 5, // 1/4 dari tinggi layar
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.0), // Warna bayangan
                    spreadRadius: 0,
                    blurRadius: 9,
                    offset: Offset(0, 9), // Perubahan posisi bayangan
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/bglogin.JPG'), // Ganti dengan path gambar Anda
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(25.0), // Padding untuk tulisan
                child: Text(
                  'Selamat Datang di\nAplikasi Administrasi dan Keuangan\nHKBP Palmarum Tarutung',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'fira',
                  ),
                ),
              ),
            ),
            // Kategori yang ada
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Riwayat Request',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'fira',
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              color: Colors.white,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imagePaths.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                      // Logic navigasi saat card ditekan
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3, // Mengatur lebar card
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9, // Menyesuaikan rasio aspek gambar
                          child: Stack(
                            children: [
                              // Background image dengan opacity
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(imagePaths[index]),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.6),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                              ),
                              // Judul di tengah card
                              Center(
                                child: Text(
                                  titles[index], // Menggunakan judul yang sesuai dengan indeks
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),



            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF03A9F3),
        index: 1,
        items: [
          Icon(Icons.home),
          Icon(Icons.history),
          Icon(Icons.person),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => home()),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profil()),
              );
              break;
          }
        },
      ),

    );
  }
}
