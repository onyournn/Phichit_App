import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // สำหรับใช้ Firestore
import 'package:flutter_application_1/pages/home/login_page.dart';
import 'package:flutter_application_1/pages/location/recommend_detail.dart';
import 'package:flutter_application_1/pages/search/search_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "SpotPich", color: AppColors.mainColor),
                  ],
                ),
                Row(
                  children: [
                    // ปุ่มค้นหา
                    GestureDetector(
                      onTap: () {
                        // นำทางไปยังหน้า SearchPage เมื่อกดปุ่มค้นหา
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: const Color.fromRGBO(137, 218, 208, 1),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width10), // เพิ่มช่องว่างระหว่างปุ่ม
                    // ปุ่มผู้ดูแลระบบ
                    GestureDetector(
                      onTap: () {
                        // นำทางไปยังหน้า LoginPage เมื่อกดปุ่ม admin_panel_settings
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.admin_panel_settings,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: const Color(0xFFffd28d), // สีของปุ่มผู้ดูแล (Admin)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // แสดงข้อมูลจาก Firestore
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('locations').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print("Error fetching locations: ${snapshot.error}");
                  return Center(child: Text('เกิดข้อผิดพลาดในการดึงข้อมูล'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('ไม่มีข้อมูลสถานที่'));
                }

                final locations = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    var location = locations[index];
                    var data = location.data() as Map<String, dynamic>?;

                    if (data == null) {
                      return ListTile(
                        title: Text('ไม่มีข้อมูล'),
                      );
                    }

                    return ListTile(
                      leading: data.containsKey('image_url') && data['image_url'] != null
                          ? Image.network(data['image_url'])
                          : Icon(Icons.image),
                      title: data.containsKey('name') && data['name'] != null
                          ? Text(data['name'])
                          : Text('ไม่มีชื่อสถานที่'),
                      subtitle: data.containsKey('location') && data['location'] != null
                          ? Text(data['location'])
                          : Text('ไม่มีข้อมูลที่ตั้ง'),
                      onTap: () {
                        // Debug: แสดง locationId ในคอนโซล
                        print('Location ID: ${location.id}');
                        // ส่ง locationId ไปยัง RecommendDetail เมื่อกดที่รายการ
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecommendDetail(locationId: location.id), // ส่ง locationId
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_history),
            label: 'ใกล้ฉัน',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
