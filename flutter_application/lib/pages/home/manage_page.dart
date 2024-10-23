import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/home/add_location.dart';
import 'package:flutter_application_1/pages/home/edit_location.dart';
import 'package:flutter_application_1/pages/home/main_page.dart';
import 'package:flutter_application_1/pages/location/recommend_detail.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/exandable_text_widgets.dart';
import 'package:flutter_application_1/widgets/icon_text_widget.dart';
import 'package:flutter_application_1/widgets/small_text.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าจัดการข้อมูล'),
      ),
      body: Column(
        children: [
          // แสดงข้อมูลจาก Firestore
          Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('locations').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
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

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: data.containsKey('image_url') && data['image_url'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data['image_url'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.image, size: 50, color: Colors.grey),
                          title: data.containsKey('name') && data['name'] != null
                              ? Text(
                                  data['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              : Text('ไม่มีชื่อสถานที่'),
                          subtitle: data.containsKey('location') && data['location'] != null
                              ? Text(data['location'])
                              : Text('ไม่มีข้อมูลที่ตั้ง'),
                          trailing: Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecommendDetail(locationId: location.id),
                              ),
                            );
                          },
                        ),
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
            icon: Icon(Icons.add),
            label: 'เพิ่มข้อมูล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'แก้ไขข้อมูล',
          ),
        ],
        selectedItemColor: AppColors.mainColor,
        onTap: (index) async {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddLocation()),
            );
          } else if (index == 2) {
            // ดึงข้อมูลเอกสารจาก Firestore
            QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('locations').get();
            if (snapshot.docs.isNotEmpty) {
              var document = snapshot.docs[0];  // ใช้เอกสารแรกในที่นี้
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditLocation(
                    documentId: document.id,
                    locationData: document.data() as Map<String, dynamic>,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
