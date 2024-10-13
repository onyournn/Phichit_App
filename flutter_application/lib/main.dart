import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/popular_place_controller.dart';
import 'package:flutter_application_1/pages/home/edit_page.dart';
import 'package:flutter_application_1/pages/home/login_page.dart';
import 'package:flutter_application_1/pages/home/main_page.dart';
import 'package:flutter_application_1/pages/home/recommend_page.dart';
import 'package:flutter_application_1/pages/location/popular_location_detail.dart';
import 'package:flutter_application_1/pages/location/recommend_detail.dart';
import 'package:flutter_application_1/pages/search/search_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart'; // Import Firebase App Check
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // เปิดใช้งาน Firebase App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,  // ใช้ Debug provider สำหรับ Android
    appleProvider: AppleProvider.debug,      // สำหรับ iOS (ถ้าจำเป็น)
  );

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularPlaceController>().getPopularPlaceList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(), // ตอนนี้ยังคง MainPage เป็นหน้าแรก
    );
  }
}
