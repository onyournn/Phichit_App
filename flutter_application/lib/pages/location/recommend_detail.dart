import 'package:flutter/material.dart'; 
import 'package:flutter_application_1/pages/home/main_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/exandable_text_widgets.dart';
import 'package:flutter_application_1/widgets/icon_text_widget.dart';
import 'package:flutter_application_1/widgets/small_text.dart';

class RecommendDetail extends StatelessWidget {
  const RecommendDetail({Key? key}) : super(key: key);

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
                    SmallText(text: "Type: Public park"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTextWidget(
                          icon: Icons.group,
                          text: "Group",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconTextWidget(
                          icon: Icons.location_on,
                          text: "1.7 km",
                          iconColor: AppColors.iconColor2,
                        ),
                        IconTextWidget(
                          icon: Icons.location_city,
                          text: "Location",
                          iconColor: AppColors.iconColor3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(
                    text: "บึงสีไฟ เป็นแหล่งน้ำจืดขนาดใหญ่ของประเทศไทย ตั้งอยู่ในจังหวัดพิจิตรบึงสีไฟเป็นแหล่งเพาะพันธุ์สัตว์น้ำจืด แหล่งอาศัยของนกหลายชนิด และยังเป็นสถานที่พักผ่อนหย่อนใจที่สำคัญของจังหวัดพิจิตรด้วย",
                  ),
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Route',
          ),
        ],
        selectedItemColor: AppColors.mainColor,
        onTap: (index) {
          if (index == 0) { // ปุ่ม Home
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()), // แทนที่ HomePage ด้วยหน้าจอที่คุณต้องการนำทางไป
            );
          } else if (index == 1) { // ปุ่ม Route
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoutePage()),
            );
          }
        },
      ),
    );
  }
}

// หน้าจอ RoutePage ที่จะไปเมื่อกดปุ่ม Route
class RoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เส้นทาง"),
      ),
      body: Center(
        child: Text("This is the Route page!"),
      ),
    );
  }
}
