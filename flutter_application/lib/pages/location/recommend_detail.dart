import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/big_text.dart';


class RecommendDetail extends StatelessWidget {
  const RecommendDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                color: Colors.white,
                child: Center(child: BigText(size:Dimensions.font26,text:"บึงสีไฟ")),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: 5, bottom:10,
                ),
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
            child: Text(
               "บึงสีไฟ เป็นแหล่งน้ำจืดขนาดใหญ่ของประเทศไทย ตั้งอยู่ในจังหวัดพิจิตรบึงสีไฟเป็นแหล่งเพาะพันธุ์สัตว์น้ำจืด แหล่งอาศัยของนกหลายชนิด และยังเป็นสถานที่พักผ่อนหย่อนใจที่สำคัญของจังหวัดพิจิตรด้วยบึงสีไฟมีจุดที่น่าสนใจหลายแห่งสวนสมเด็จพระศรีนครินทร์ พิจิตร สร้างขึ้นเพื่อเฉลิมพระเกียรติสมเด็จพระศรีนครินทราบรมราชชนนีรูปปั้นพญาชาลวัน ตามตำนานเรื่องไกรทอง สถานแสดงพันธุ์ปลาเฉลิมพระเกียรติ หรือที่นิยมเรียกกันว่า ศาลาเก้าเหลี่ยม ศาลากลางน้ำ คือศาลาที่ตั้งอยู่บนบึงสีไฟ มีทั้งหมด 4 ศาลา นักท่องเที่ยวนิยมมาให้อาหารสัตว์น้ำบนศาลา บ่อจระเข้  มีมุมพักผ่อน ที่นั่งเล่น ชมวิวริมบึง เป็นอีกหนึ่งจุดถ่ายรูปที่สวยงามเป็นอีกหนึ่งจุดถ่ายรูปที่สวยงามnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnเป็นอีกหนึ่งจุดถ่ายรูปที่สวยงามnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnเป็นอีกหนึ่งจุดถ่ายรูปที่สวยงามnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn"
            ),
          )
        ],
      ),
    );
  }
}