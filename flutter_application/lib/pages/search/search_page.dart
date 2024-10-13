import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/login_page.dart';
import 'package:flutter_application_1/pages/home/main_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
 // เพิ่มการนำเข้าไฟล์ login_page.dart
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  
  int _selectedIndex = 0; // เก็บค่าดัชนีของแถบที่ถูกเลือก
  
  // ลิสต์ข้อมูลสถานที่ที่มีชื่อและรูปแบบ Asset
  List<Map<String, String>> _places = [
    {'name': 'บึงสีไฟ', 'image': 'assets/images/buengsifai2.jpg'},
    {'name': 'ลานเวลา', 'image': 'assets/images/lanvela1.jpg'},
    {'name': 'ตลาดเก่าวังกรด', 'image': 'assets/images/wangkrot1.jpg'},
    {'name': 'วัดโพธิ์ประทับช้าง', 'image': 'assets/images/watpo1.jpg'},
    {'name': 'บะหมี่ลิ้นชัก', 'image': 'assets/images/bamilinchak1.jpg'},
    {'name': 'สะพานศิลป์', 'image': 'assets/images/sapansin.jpg'},
    {'name': 'วัดเขารูปช้าง', 'image': 'assets/images/watkhao1.jpg'},
  ];

  List<Map<String, String>> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = _places;
  }

  // ฟังก์ชันลบวรรณยุกต์และสระพิเศษออกจากข้อความ
  String removeThaiTone(String input) {
    return input.replaceAll(RegExp(r'[่-๋]'), ''); // ลบวรรณยุกต์ในภาษาไทย
  }

  void _filterPlaces(String query) {
    List<Map<String, String>> _results = [];
    String searchQuery = removeThaiTone(query.toLowerCase());

    if (searchQuery.isEmpty) {
      _results = _places;
    } else {
      _results = _places.where((place) {
        String placeName = removeThaiTone(place['name']!.toLowerCase());
        return placeName.contains(searchQuery);
      }).toList();
    }

    setState(() {
      _filteredPlaces = _results;
    });
  }

  // ฟังก์ชันสำหรับเปลี่ยนหน้าเมื่อเลือกแถบด้านล่าง
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // นำทางไปยังหน้า main_page.dart เมื่อกดปุ่ม "Home" (index = 0)
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
    // นำทางไปยังหน้า login_page.dart เมื่อกดปุ่ม "แก้ไข" (index = 2)
    else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาสถานที่ท่องเที่ยว'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ค้นหาสถานที่...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onChanged: (value) {
                  _filterPlaces(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryButton(Icons.local_offer, 'ลดราคาพิเศษ'),
                  buildCategoryButton(Icons.star, 'แนะนำ'),
                  buildCategoryButton(Icons.place, 'ใกล้คุณ'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredPlaces.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5,  // ปรับสัดส่วนความสูง
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // เพิ่มความโค้งมนให้กรอบรูป
                    ),
                    child: Column(
                      children: [
                        // รูปภาพที่โค้งมนขึ้น
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20), // เพิ่มความโค้งมนให้รูปภาพ
                          child: Image.asset(
                            _filteredPlaces[index]['image']!,
                            fit: BoxFit.cover,
                            height: 150, // กำหนดความสูงของรูปภาพ
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(height: 8), // ระยะห่างระหว่างรูปภาพและตัวอักษร
                        // ชื่อสถานที่อยู่ใต้รูปภาพ
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            _filteredPlaces[index]['name']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: 'แก้ไข',
          ),
        ],
         currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildCategoryButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 40, color: const Color.fromRGBO(137, 218, 208, 1)),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
