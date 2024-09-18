import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:flutter_application_1/widgets/exandable_text_widgets.dart';

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
              children: [
                AppIcon(icon: Icons.clear),
                //AppIcon(icon: Icons.)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                //margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                //color: Colors.white,
                child: Center(
                    child: BigText(size: Dimensions.font26, text: "บึงสีไฟ")),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
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
                "assets/images/im00.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                child: ExpandableTextWidget(
                    text:
                        "บึงสีไฟ เป็นแหล่งน้ำจืดขนาดใหญ่ของประเทศไทย ตั้งอยู่ในจังหวัดพิจิตรบึงสีไฟเป็นแหล่งเพาะพันธุ์สัตว์น้ำจืด แหล่งอาศัยของนกหลายชนิด และยังเป็นสถานที่พักผ่อนหย่อนใจที่สำคัญของจังหวัดพิจิตรด้วยบึงสีไฟมีจุดที่น่าสนใจบึงสีไฟ เป็นแหล่งน้ำจืดขนาดใหญ่ของประเทศไทย ตั้งอยู่ในจังหวัดพิจิตรบึงสีไฟเป็นแหล่งเพาะพันธุ์สัตว์น้ำจืด แหล่งอาศัยของนกหลายชนิด และยังเป็นสถานที่พักผ่อนหย่อนใจที่สำคัญของจังหวัดพิจิตรด้วยบึงสีไฟมีจุดที่น่าสนใจบึงสีไฟ เป็นแหล่งน้ำจืดขนาดใหญ่ของประเทศไทย ตั้งอยู่ในจังหวัดพิจิตรบึงสีไฟเป็นแหล่งเพาะพันธุ์สัตว์น้ำจืด แหล่งอาศัยของนกหลายชนิด และยังเป็นสถานที่พักผ่อนหย่อนใจที่สำคัญของจังหวัดพิจิตรด้วยบึงสีไฟมีจุดที่น่าสนใจบึงสีไฟ เป็นแหล่งน้ำจืดขนาดใหญ่ของประเทศไทย ตั้งอยู่ในจังหวัดพิจิตรบึงสีไฟเป็นแหล่งเพาะพันธุ์สัตว์น้ำจืด แหล่งอาศัยของนกหลายชนิด และยังเป็นสถานที่พักผ่อนหย่อนใจที่สำคัญของจังหวัดพิจิตรด้วยบึงสีไฟมีจุดที่น่าสนใจ"),
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
              ),
            ],
          ))
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //     padding: EdgeInsets.only(
          //         left: Dimensions.width20 * 2.5,
          //         right: Dimensions.width20 * 2.5,
          //         top: Dimensions.height10,
          //         bottom: Dimensions.height10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         AppIcon(
          //           iconSize: Dimensions.iconSize24,
          //           iconColor: Colors.white,
          //           backgroundColor: AppColors.mainColor,
          //           icon: Icons.star_border,
          //         ),
          //       ],
          //     )),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.height20,
                right: Dimensions.height20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Container(
              // padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              // decoration: BoxDecoration(
              //  borderRadius: BorderRadius.circular(Dimensions.radius20),
              // color: Colors.white
              // ),
              //), ปุ่มสีขาว
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on, // ใช้ไอคอนที่คุณต้องการ
                      color: Colors.white, // สีของไอคอน
                    ),
                    SizedBox(
                        width: Dimensions
                            .width10), // ช่องว่างระหว่างไอคอนและข้อความ
                    BigText(
                      text: "Route",
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
