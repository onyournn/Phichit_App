import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';  // สำหรับเลือกภาพ
import 'dart:io';  // สำหรับจัดการไฟล์
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference locations = FirebaseFirestore.instance.collection('locations');

  File? _selectedImage;  // เก็บภาพที่เลือก
  final ImagePicker _picker = ImagePicker();  // สำหรับเลือกภาพ
  bool _isLoading = false;  // สถานะการโหลด

  // ฟังก์ชันเลือกภาพจากแกลเลอรี
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // ฟังก์ชันอัพโหลดรูปภาพไปที่ Firebase Storage
  Future<String?> _uploadImage(File image) async {
    try {
      print("เริ่มการอัปโหลดรูปภาพ...");

      // สร้าง reference สำหรับรูปภาพใน Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('location_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      print("สร้าง reference สำเร็จแล้ว");

      // อัพโหลดไฟล์
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      print("อัปโหลดเสร็จสิ้นแล้ว");

      // รับ URL ของรูปภาพที่อัพโหลดสำเร็จ
      String downloadURL = await snapshot.ref.getDownloadURL();
      print("ได้รับ URL ของรูปภาพ: $downloadURL");
      return downloadURL;
    } catch (e) {
      print("เกิดข้อผิดพลาดในการอัพโหลดรูปภาพ: $e");
      return null;
    }
  }

  void _saveNewLocation() async {
    String name = _nameController.text;
    String location = _locationController.text;
    String description = _descriptionController.text;

    if (name.isNotEmpty && location.isNotEmpty && description.isNotEmpty && _selectedImage != null) {
      setState(() {
        _isLoading = true;  // เริ่มการโหลด
      });

      print("เริ่มอัปโหลดรูปภาพ...");

      // อัพโหลดรูปภาพไปที่ Firebase Storage
      String? imageUrl = await _uploadImage(_selectedImage!);

      if (imageUrl != null) {
        print("เริ่มบันทึกข้อมูลไปยัง Firestore...");
        // บันทึกข้อมูลไปยัง Firestore
        await locations.add({
          'name': name,
          'location': location,  // ใช้ 'location' แทน 'type'
          'description': description,
          'image_url': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        }).then((value) {
          setState(() {
            _isLoading = false;  // การบันทึกเสร็จสิ้น
          });
          print("บันทึกข้อมูลสำเร็จ");

          // แสดงข้อความยืนยันว่าบันทึกข้อมูลสำเร็จ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('บันทึกข้อมูลสำเร็จ')),
          );

          // ล้างข้อมูลในฟิลด์ทั้งหมด
          _nameController.clear();
          _locationController.clear();
          _descriptionController.clear();
          setState(() {
            _selectedImage = null;  // รีเซ็ตภาพที่เลือก
          });
        }).catchError((error) {
          setState(() {
            _isLoading = false;  // หากเกิดข้อผิดพลาด
          });
          print("เกิดข้อผิดพลาดในการบันทึกข้อมูล: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ไม่สามารถบันทึกข้อมูลได้: $error')),
          );
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('การอัพโหลดรูปภาพล้มเหลว')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วนและเลือกภาพ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: 'เพิ่มสถานที่ใหม่', size: Dimensions.font26),
        backgroundColor: AppColors.mainColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())  // แสดง Loading ขณะอัพโหลดข้อมูล
          : Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.height20),

                    // ช่องกรอกชื่อสถานที่
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อสถานที่',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),

                    // ช่องกรอกที่ตั้ง
                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'ที่ตั้ง',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),

                    // ช่องกรอกรายละเอียด
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'รายละเอียด',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: Dimensions.height20),

                    // แสดงรูปภาพที่เลือก หรือปุ่มเลือกภาพ
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: _selectedImage == null
                              ? Icon(Icons.camera_alt, color: Colors.grey, size: 50)
                              : Image.file(_selectedImage!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height30),

                    // ปุ่มบันทึกข้อมูลสถานที่ใหม่
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveNewLocation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width30,
                              vertical: Dimensions.height15),
                        ),
                        child: Text(
                          'บันทึกสถานที่',
                          style: TextStyle(fontSize: Dimensions.font20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
