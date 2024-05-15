import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hkbp_palmarum_app/user/home.dart';
import 'package:hkbp_palmarum_app/user/isiwartajemaat.dart';
import 'package:hkbp_palmarum_app/user/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WartaJemaat extends StatefulWidget {
  final String token;
  const WartaJemaat({required this.token, Key? key}) : super(key: key);

  @override
  _WartaJemaatState createState() => _WartaJemaatState();
}

class _WartaJemaatState extends State<WartaJemaat> {
  List<Map<String, dynamic>> wartaList = [];
  bool isApiActive = true;

  Future<void> fetchWarta() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.21.80:2005/warta'));
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> responseData = json.decode(response.body);
          wartaList = List<Map<String, dynamic>>.from(responseData['data']);
          print(wartaList);
        });
      } else {
        setState(() {
          isApiActive = false; // Set flag to false if API call fails
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isApiActive = false; // Set flag to false if API call throws an exception
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWarta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warta Jemaat',
          style: TextStyle(
            fontFamily: 'fira',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home(token: widget.token)),
            );
          },
        ),
        backgroundColor: Color(0xFF03A9F3),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundprofil.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          isApiActive
              ? SingleChildScrollView(
            padding: EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 60),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: wartaList.map((warta) {
                String? createAt = warta['create_at'] as String?;
                final createAtString = createAt ?? 'No date';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IsiWartaJemaat(token: widget.token, id: warta['id_warta'].toString()),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 6),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('assets/bglogin.JPG'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            'Warta Jemaat\n $createAtString',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'fira',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
              : Center(
            child: Text('Failed to load data'),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF03A9F3),
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
                MaterialPageRoute(builder: (context) => home(token: widget.token)),
              );
              break;
            case 1:
            // Handle index 1
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profil(token: widget.token)),
              );
              break;
          }
        },
        index: 0,
      ),
    );
  }
}
