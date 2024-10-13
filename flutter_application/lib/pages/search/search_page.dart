import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  
  // ลิสต์ข้อมูลสถานที่ที่มีชื่อและรูปแบบ Asset
  List<Map<String, String>> _places = [
    {'name': 'บึงสีไฟ', 'image': 'assets/images/buengsifai2.jpg'},
    {'name': 'Lanvela', 'image': 'assets/images/lanvela1.jpg'},
    {'name': 'Wangkrot', 'image': 'assets/images/wangkrot1.jpg'},
    {'name': 'WatPo', 'image': 'assets/images/watpo1.jpg'},
    {'name': 'Bamilinchak', 'image': 'assets/images/bamilinchak1.jpg'},
    {'name': 'สะพานศิลป์', 'image': 'assets/images/sapansin.jpg'},
    {'name': 'วัดเขารูปช้าง', 'image': 'assets/images/wathkao1.jpg'},
  ];

  List<Map<String, String>> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = _places;
  }

  void _filterPlaces(String query) {
    List<Map<String, String>> _results = [];
    if (query.isEmpty) {
      _results = _places;
    } else {
      _results = _places
          .where((place) =>
              place['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredPlaces = _results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาสถานที่ท่องเที่ยว'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // เพิ่มฟังก์ชันการใช้งานสำหรับรายการโปรด
            },
          ),
        ],
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
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridTile(
                      header: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          _filteredPlaces[index]['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ใช้ Image.asset เพื่อแสดงรูปภาพจาก Asset
                      child: Image.asset(
                        _filteredPlaces[index]['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.green),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
