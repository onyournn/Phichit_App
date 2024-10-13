import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart'; // นำเข้า Dots Indicator
import 'package:flutter_application_1/utils/colors.dart'; // ใช้ colors จากโปรเจกต์ของคุณ
import 'package:flutter_application_1/utils/dimensions.dart'; // ใช้ dimensions จากโปรเจกต์ของคุณ
import 'package:flutter_application_1/widgets/app_column.dart';
import 'package:flutter_application_1/widgets/icon_text_widget.dart'; // ใช้ icon_text_widget จากโปรเจกต์ของคุณ
import 'package:flutter_application_1/widgets/big_text.dart'; // ใช้ big_text widget จากโปรเจกต์ของคุณ
import 'package:flutter_application_1/widgets/small_text.dart'; // ใช้ small_text widget จากโปรเจกต์ของคุณ

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // เพิ่ม Scaffold เพื่อให้แน่ใจว่าเรามีโครงสร้างที่ถูกต้อง
      body: SingleChildScrollView( // ห่อด้วย SingleChildScrollView เพื่อให้เลื่อนหน้าได้เมื่อเนื้อหายาวเกินไป
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // จัดข้อความให้อยู่ทางซ้าย
          children: [
            // Slider section
            Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                },
              ),
            ),
            // Dots Indicator
            Center(
            child: DotsIndicator(
              dotsCount: 5, 
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            ),
            SizedBox(height: Dimensions.height15),
            // ListView.builder ห่อด้วย Container ที่กำหนดขนาด
            Container(
              height: MediaQuery.of(context).size.height * 0.6, // ใช้ MediaQuery เพื่อให้ขนาดเหมาะสมกับหน้าจอ
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(), // ปิดการ scroll ของ ListView เพราะใช้ SingleChildScrollView แล้ว
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.height10,
                      right: Dimensions.height10,
                      bottom: Dimensions.height10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.ListViewImgSize,
                          height: Dimensions.ListViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/buengsifai1.jpg"),
                            ),
                          ),
                        ),
                        Expanded( // ใช้ Expanded เพื่อลดปัญหา overflow
                          child: Container(
                            height: Dimensions.ListViewTextContSize,
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
                                  BigText(text: "บึงสีไฟ"),
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
                                      //IconTextWidget(
                                        //icon: Icons.sunny,
                                        //text: "Season",
                                        //iconColor: AppColors.iconColor3,
                                      //),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/watkhao1.jpg"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.radius15,
                right: Dimensions.radius15,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height10,
                  right: Dimensions.height10,
                ),
                child: AppColumn(text: "บึงสีไฟ"), // เปลี่ยนจาก AppColumn เป็นข้อความตรงๆ
              ),
            ),
          ),
        ],
      ),
    );
  }
}
