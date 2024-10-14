import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/main_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/exandable_text_widgets.dart';
import 'package:flutter_application_1/widgets/icon_text_widget.dart';
import 'package:flutter_application_1/widgets/small_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // นำเข้า Firestore

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  void _setRating(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  // ฟังก์ชันบันทึกรีวิวไปยัง Firestore
  void _submitReview() async {
    String comment = _commentController.text;

    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณาเลือกจำนวนดาว')),
      );
    } else if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกความคิดเห็น')),
      );
    } else {
      try {
        await FirebaseFirestore.instance.collection('reviews').add({
          'rating': _selectedRating,
          'comment': comment,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('บันทึกรีวิวเรียบร้อย')),
        );

        _commentController.clear();
        _setRating(0);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(size: Dimensions.font26, text: "บึงสีไฟ")),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20))),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.iconColor3,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/buengsifai1.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  bottomRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width10,
                  right: Dimensions.width10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: Dimensions.height10),
                    SmallText(text: ""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTextWidget(
                          icon: Icons.group,
                          text: "กลุ่ม",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconTextWidget(
                          icon: Icons.location_on,
                          text: "1.7 km",
                          iconColor: AppColors.iconColor2,
                        ),
                        IconTextWidget(
                          icon: Icons.location_city,
                          text: "สถานที่ท่องเที่ยว",
                          iconColor: AppColors.iconColor3,
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20),

                    // ดึงข้อมูลจาก Firestore มาแสดง
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('locations').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return Column(
                          children: snapshot.data!.docs.map((document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpandableTextWidget(
                                  text: data['description'] ?? 'ไม่มีรายละเอียด', onExpandedChanged: (isExpanded) {  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: Image.network(
                                          data['image_url'] ?? '',
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: Image.network(
                                          data['image_url'] ?? '',
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),

                    SizedBox(height: Dimensions.height20),

                    // ส่วนการรีวิว
                    BigText(text: 'รีวิวและแสดงความคิดเห็น', size: Dimensions.font20),
                    SizedBox(height: Dimensions.height10),

                    // ดึงข้อมูลจาก Firestore เพื่อแสดงรีวิว
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var review = snapshot.data!.docs[index];
                              int rating = review['rating'];

                              // เปลี่ยนจากแสดงตัวเลขเป็นดาว
                              return ListTile(
                                title: Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < rating ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                    );
                                  }),
                                ),
                                subtitle: Text(review['comment']),
                              );
                            },
                          );
                        }
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _selectedRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () => _setRating(index + 1),
                        );
                      }),
                    ),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'แสดงความคิดเห็น',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: Dimensions.height20),

                    Center(
                      child: ElevatedButton(
                        onPressed: _submitReview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width30,
                              vertical: Dimensions.height15),
                        ),
                        child: Text('ส่งรีวิว'),
                      ),
                    ),
                  ],
                ),
              ),
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
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          } else if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('คุณกดปุ่มข้อมูลเพิ่มเติม')),
            );
          }
        },
      ),
    );
  }
}
