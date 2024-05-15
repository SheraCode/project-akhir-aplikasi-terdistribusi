import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/admin/JadwalIbadah.dart';
import 'package:hkbp_palmarum_app/admin/PelayanIbadahKebaktian.dart';
import 'package:hkbp_palmarum_app/admin/Pengeluaran.dart';
import 'package:hkbp_palmarum_app/admin/WartaJemaat.dart';
import 'package:hkbp_palmarum_app/admin/baptis.dart';
import 'package:hkbp_palmarum_app/admin/home.dart';
import 'package:hkbp_palmarum_app/admin/kegiatan.dart';
import 'package:hkbp_palmarum_app/admin/pelayanIbadah.dart';
import 'package:hkbp_palmarum_app/admin/pemasukan.dart';
import 'package:hkbp_palmarum_app/admin/malua.dart';
import 'package:hkbp_palmarum_app/admin/pemasukan.dart';
import 'package:hkbp_palmarum_app/admin/pernikahan.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:hkbp_palmarum_app/user/login.dart';

class DrawerWidget extends StatefulWidget {


  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
    _loadNamaDepanFromSharedPreferences();
  }

  late String namaDepan = '';
  late String namaBelakang = '';
  late String email = '';
  late String foto = '';
  late int id_user;

  Future<void> _loadNamaDepanFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('token'); // Mengambil token dari SharedPreferences
    print(savedToken);
    if (savedToken != null && savedToken.isNotEmpty) {
      try {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(savedToken);
        setState(() {
          namaDepan = decodedToken['nama_depan']; // Setel namaDepan menggunakan token yang disimpan
          namaBelakang = decodedToken['nama_belakang'];
          email = decodedToken['email'];
          foto = decodedToken['foto_jemaat'];
          id_user = decodedToken['id_jemaat'];
        });
      } catch (error) {
        print('Error decoding token: $error');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.indigo
                ),
                accountName: Text('$namaDepan', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                accountEmail: Text(email, style: TextStyle(
                  fontSize: 16,

                ),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('http://192.168.21.80:2010/jemaat/$id_user/image'),
                ),
              )
          ),

          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => admin()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pernikahan()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Pernikahan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => baptis()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Baptis",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => malua()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Marguru Manaksihon",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JadwalIbadah()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Jadwal Ibadah",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),



          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PelayanKebaktian()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Anggota Pelayan Ibadah",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),



          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PelayanIbadah()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Pelayan Kebaktian",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => kegiatan()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Kegiatan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WartaJemaat()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.blue,
              ),
              title: Text(
                "Warta Jemaat",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pemasukan()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.monetization_on_outlined,
                color: Colors.blue,
              ),
              title: Text(
                "Pemasukan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pengeluaran()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.monetization_on_outlined,
                color: Colors.blue,
              ),
              title: Text(
                "Pengeluaran",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              // Tambahkan logika untuk navigasi ke halaman wishlist di sini
              // Contoh:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.blue,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}