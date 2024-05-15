import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';

class KelolaPernikahan extends StatelessWidget {
  var height, width;



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
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kelola Pernikahan",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Request Surat Pernikahan Jemaat",
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
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/wedding.png",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Tambahan widget lainnya
                          Padding(padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nama Calon Laki-laki',
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0), // Ubah nilai radius sesuai keinginan Anda
                                ),
                              ),
                            )
                            ,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nama Calon Perempuan',
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0), // Ubah nilai radius sesuai keinginan Anda
                                ),
                              ),
                            )
                            ,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Telephone',
                                hintText: 'Enter your Telephone',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0), // Ubah nilai radius sesuai keinginan Anda
                                ),
                              ),
                            )
                            ,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                            child: TextFormField(
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Alamat ',
                                hintText: 'Enter your address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0), // Ubah nilai radius sesuai keinginan Anda
                                ),
                              ),
                            ),

                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){},
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
                                  Icon(Icons.check_circle_outline, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(
                                    'Terima',
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
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){},
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
                                    'Tolak',
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
      drawer: DrawerWidget(), // Panggil DrawerWidget
    );
  }
}
