import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/recommend_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
// ignore: unused_import
import 'package:flutter_application_1/widgets/small_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    //print("current height is"+MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
        child: Container(
          margin: EdgeInsets.only(top:Dimensions.height45, bottom:Dimensions.height15),
          padding: EdgeInsets.only(left:Dimensions.width20, right:Dimensions.width20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(text:"Phichit App", color: AppColors.mainColor),
                Row(
                  //children: [
                    //SmallText(text: "District", color: Colors.black54),
                    //Icon(Icons.arrow_drop_down_rounded)
                  //],
                )
              ],
            ),
            
            Center(
              child: Container(
                width: Dimensions.height45,
                height: Dimensions.height45,
                child: Icon(Icons.search, color: Colors.white, size:Dimensions.iconSize24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: const Color.fromARGB(255, 244, 209, 12),
                ),
                ),
            ),
            
          ],
        ),
      ),
        ),
        Expanded(child: SingleChildScrollView(
          child: RecommendPage(),
        )),
       ],
       
      ),
    );
  }
}