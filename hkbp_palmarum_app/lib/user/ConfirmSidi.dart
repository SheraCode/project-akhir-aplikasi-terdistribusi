import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hkbp_palmarum_app/user/RegistrasiSidi.dart';
import 'package:hkbp_palmarum_app/user/home.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmSidi extends StatefulWidget {
  @override
  _createConfirmSidiState createState() => _createConfirmSidiState();
}

class _createConfirmSidiState extends State<ConfirmSidi> {
  var height, width;
  List<String> _dropdownItems = [
    'Johannes Bastian Jasa Sipayung, S.Tr.Kom',
    'Christia Otenia Br Purba, S.M',
    'Bastian Otenia Sipayung',

    // Tambahkan nama lainnya sesuai kebutuhan
  ];

  String? _selectedName; // inisialisasi _selectedName

  String? _selectedChurch;
  String? _otherChurchName;

  List<String> _churchList = ['HKBP', 'Gereja lain'];

  bool _showOtherChurchTextField = false;
  TextEditingController _otherChurchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/angkatsidi.jpeg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: height * 0.22,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding:
                          EdgeInsets.only(top: 25, left: 15, right: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Widget yang Anda ingin masukkan di sini
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Angkat Sidi",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Request Surat Angkat Sidi Jemaat",
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
                    //   coding diisini
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Tambahan widget lainnya
                          TextField(

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Nama Calon Sidi',
                              hintText: "Nama Calon Sidi",
                              errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              prefixIcon: Icon(Icons.person), // Icon surat untuk email
                            ),
                          ).p4().px24(),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Jenis Kelamin',
                              hintText: "Jenis Kelamin",
                              errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              prefixIcon: Icon(Icons.male_sharp), // Icon surat untuk email
                            ),
                          ).p4().px24(),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Tanggal Lahir',
                              hintText: "Tanggal Lahir",
                              errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              prefixIcon: Icon(Icons.date_range), // Icon surat untuk email
                            ),
                          ).p4().px24(),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Nama Ayah',
                              hintText: "Nama Ayah",
                              errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              prefixIcon: Icon(Icons.person), // Icon surat untuk email
                            ),
                          ).p4().px24(),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Nama Ibu',
                              hintText: "Nama Ibu",
                              errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              prefixIcon: Icon(Icons.person), // Icon surat untuk email
                            ),
                          ).p4().px24(),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 9, horizontal: 18),
                            child: Column(
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Pilih Gereja',
                                    hintText: 'Pilih Gereja calon baptis',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  value: _selectedChurch,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedChurch = newValue;
                                      if (newValue == 'Gereja lain') {
                                        _showOtherChurchTextField = true;
                                      } else {
                                        _showOtherChurchTextField = false;
                                      }
                                    });
                                  },
                                  items: _churchList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ).p1().px4(),
                                SizedBox(height: 10),
                                if (_showOtherChurchTextField)
                                  TextFormField(
                                    controller: _otherChurchController,
                                    decoration: InputDecoration(
                                      labelText: 'Nama Gereja',
                                      hintText: 'Masukkan nama gereja',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ).p4().px4(),
                              ],
                            ),
                          ),


                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => home()),
                              );
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
                                    'Request',
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
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegistrasiSidi()),
                              );
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
                                  Icon(Icons.navigate_before,
                                      color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(
                                    'Kembali',
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
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        items: [
          Icon(Icons.home),
          Icon(Icons.history),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
