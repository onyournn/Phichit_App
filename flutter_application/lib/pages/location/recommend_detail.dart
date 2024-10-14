import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/exandable_text_widgets.dart';
import 'package:flutter_application_1/widgets/icon_text_widget.dart';
import 'package:flutter_application_1/widgets/small_text.dart';  // นำเข้า SmallText

class RecommendDetail extends StatefulWidget {
  final String locationId; // รับ locationId เป็นตัวแปรใน RecommendDetail

  const RecommendDetail({Key? key, required this.locationId}) : super(key: key);

  @override
  _RecommendDetailState createState() => _RecommendDetailState();
}

class _RecommendDetailState extends State<RecommendDetail> {
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
        // บันทึกข้อมูลรีวิวไปยัง Firestore
        await FirebaseFirestore.instance.collection('reviews').add({
          'locationId': widget.locationId, // ผูกรีวิวกับ locationId ที่รับมา
          'rating': _selectedRating,
          'comment': comment,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('บันทึกรีวิวเรียบร้อย')),
        );

        // ล้างข้อมูลในฟิลด์หลังจากบันทึกเรียบร้อยแล้ว
        _commentController.clear();
        _setRating(0); // รีเซ็ตจำนวนดาวหลังจากบันทึกรีวิว
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Debug: แสดง locationId ที่ได้รับมา
    print('Received Location ID: ${widget.locationId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('locations')
            .doc(widget.locationId)
            .get(), // ดึงข้อมูลสถานที่จาก Firestore
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}"); // พิมพ์ข้อผิดพลาดในคอนโซล
            return Center(child: Text('เกิดข้อผิดพลาดในการดึงข้อมูล'));
          }

          var locationData = snapshot.data!.data() as Map<String, dynamic>?;

          if (locationData == null) {
            print('ไม่มีข้อมูลจาก Firestore');
            return Center(child: Text('ไม่มีข้อมูลจาก Firestore'));
          }

          print("Location Data: $locationData"); // พิมพ์ข้อมูลที่ดึงได้จาก Firestore

          return CustomScrollView(
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
                        child: BigText(
                            size: Dimensions.font26,
                            text: locationData['name'] ?? 'ไม่มีชื่อสถานที่')),
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
                  background: locationData['image_url'] != null
                      ? Image.network(
                          locationData['image_url'],
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        )
                      : Center(child: Icon(Icons.image, size: 100, color: Colors.grey)),
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
                        SmallText(text: locationData['description'] ?? 'ไม่มีรายละเอียด'),
                        SizedBox(height: Dimensions.height20),
                        ExpandableTextWidget(
                          text: locationData['description'] ?? '',
                          onExpandedChanged: (isExpanded) {},
                        ),
                        SizedBox(height: Dimensions.height20),

                        // ส่วนการเขียนรีวิวและให้คะแนน
                        BigText(
                            text: 'เขียนรีวิวและให้คะแนน',
                            size: Dimensions.font20),
                        SizedBox(height: Dimensions.height10),

                        // ปุ่มเลือกดาว
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _selectedRating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () => _setRating(index + 1), // ให้คะแนน
                            );
                          }),
                        ),

                        // ช่องกรอกคอมเมนต์
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

                        // ปุ่มส่งรีวิว
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

                        SizedBox(height: Dimensions.height30),

                        // ดึงข้อมูลรีวิวจาก Firestore
                        BigText(
                            text: 'รีวิวจากผู้ใช้',
                            size: Dimensions.font20),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('reviews')
                              .where('locationId',
                                  isEqualTo: widget.locationId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text('ยังไม่มีรีวิวสำหรับสถานที่นี้'),
                              );
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
                                          index < rating
                                              ? Icons.star
                                              : Icons.star_border,
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
