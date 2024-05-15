import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class pelayangereja extends StatefulWidget {
  @override
  _PelayanGerejaState createState() => _PelayanGerejaState();
}

class _PelayanGerejaState extends State<pelayangereja> {
  late List<dynamic> pelayanGerejaList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('http://192.168.21.80:2007/pelayan-gereja'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('pelayanGerejaList: $responseData'); // Tambahkan ini
      setState(() {
        pelayanGerejaList = responseData != null ? List.from(responseData) : [];
        isLoading = false;
        print(pelayanGerejaList);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> filterByStatus(String status) {
    return pelayanGerejaList.where((pelayan) => pelayan['status_pelayan'] == status).toList();
  }

  Widget buildTable(String status, List<dynamic> data) {
    if (status == 'Bendahara' ||
        status == 'Sekretaris' ||
        status == 'Ketua' ||
        status == 'Wakil Ketua') {
      return Column(
        children: [
          SizedBox(height: 20),
          Text(
            status,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.black,
            ),
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Jabatan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Nama',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: data.map<DataRow>((pelayan) {
                return DataRow(cells: <DataCell>[
                  DataCell(Text(
                    status,
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    pelayan['nama_pelayan'],
                    style: TextStyle(color: Colors.white),
                  )),
                ]);
              }).toList(),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 20),
          Text(
            status,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.black,
            ),
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Nama',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: data.map<DataRow>((pelayan) {
                return DataRow(cells: <DataCell>[
                  DataCell(Text(
                    pelayan['nama_pelayan'],
                    style: TextStyle(color: Colors.white),
                  )),
                ]);
              }).toList(),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pelayan Gereja',
          style: TextStyle(
            fontFamily: 'fira',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF03A9F3),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgroundprofil.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
                BlendMode.darken,
              ),
            ),
          ),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              if (pelayanGerejaList.isNotEmpty)
                ...[
                  buildTable(
                    'Pendeta',
                    filterByStatus('Pendeta'),
                  ),
                  buildTable(
                    'Sintua',
                    filterByStatus('Majelis Jemaat'),
                  ),
                  buildTable(
                    'Bendahara',
                    filterByStatus('Bendahara'),
                  ),
                  buildTable(
                    'Sekretaris',
                    filterByStatus('Sekretaris'),
                  ),
                  buildTable(
                    'Wakil Ketua',
                    filterByStatus('Wakil Ketua'),
                  ),
                  buildTable(
                    'Ketua',
                    filterByStatus('Ketua'),
                  ),
                ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF03A9F3),
        items: [
          Icon(Icons.home),
          Icon(Icons.history),
          Icon(Icons.person),
        ],
        onTap: (index) {
          // Handle navigation here
        },
        index: 0,
      ),
    );
  }
}
