import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/main_page.dart';
import 'package:flutter_application_1/pages/location/popular_location_detail.dart';
import 'package:flutter_application_1/pages/location/recommend_detail.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RecommendDetail(),
    );
  }
}









