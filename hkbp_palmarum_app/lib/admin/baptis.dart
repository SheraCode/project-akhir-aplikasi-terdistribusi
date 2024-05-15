import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/admin/KelolaBaptis.dart';
import 'package:hkbp_palmarum_app/admin/KelolaPernikahan.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';

class baptis extends StatelessWidget {
  var height, width;

  List<String> imgSrc = [
    "assets/baptis.png",
    "assets/baptis.png",
    "assets/baptis.png",
    "assets/baptis.png",
    "assets/baptis.png",
    // "assets/baptis.png",
    // "assets/baptis.png",
  ];

  List<String> titles = [
    "Johannes Bastian Jasa Sipayung",
    "Christia Otenia Purba",
    "Desna Warintan",
    "Nastar Adelina",
    "Ihsan",
    "Matthew Haholongan",
  ];

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
                      Padding(padding: EdgeInsets.only(top: 25, left: 15, right: 15)),
                      Row(
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            right: 15
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pembaptisan",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Request Surat Pembaptisan Jemaat",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white54,
                                  letterSpacing: 1
                              ),
                            )
                          ],
                        ),
                      )
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
                        )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: imgSrc.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){},
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 6
                                    )
                                  ]
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      imgSrc[index],
                                      width: 80, // Mengurangi lebar gambar
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          titles[index],
                                          style: TextStyle(
                                              fontSize: 18, // Mengurangi ukuran teks
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          "Request Surat Pembaptisan Jemaat ${titles[index]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 16, bottom: 8), // Atur jarak dari kanan dan bawah
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => KelolaBaptis()),
                                                );
                                                // Aksi saat tombol ditekan
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Atur padding tombol
                                              ),
                                              child: Text('Kelola'),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: DrawerWidget(), // Panggil DrawerWidget
    );
  }
}
