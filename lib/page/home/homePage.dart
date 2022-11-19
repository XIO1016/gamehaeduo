import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage1.dart';
import 'package:cau_gameduo/page/myPage/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/home/homePageController.dart';
import '../../components/SizedBox.dart';
import 'package:cau_gameduo/page/myPage/settingPage.dart';
import 'dart:math' as math;

class homePage extends GetView<homePageController> {


  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
            appBar: AppBar(
              title:
              Row(
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: 50,
                    height: 50,
                  ),
                  Text('게임해듀오',
                      style: TextStyle(color: maincolor, fontSize: 14,) ),
                ],
              )),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('별점이 높은 유저를 만나보세요',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Text('같이 게임을 즐길 듀오를 구해보세요',
                  style: TextStyle(fontSize: 12,)),
              Sbox(0, 10),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: (controller.closeTopContainer.value==0)?150:180,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            height: 180,
                            width: 120,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFD1D1D1),
                                borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width:1,
                              color: Colors.grey,
                            )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(//프로필 사진
                                  controller.myprofile.image,
                                  fit: BoxFit.fitWidth,
                                ),
                                Sbox(0, 5),
                                Text((controller.myprofile.nick=='')?'닉네임':controller.myprofile.nick),
                                Sbox(0, 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Image.asset(//랭크 사진
                                  "images/point.png",
                                  width: 20,
                                    height: 20,
                                ),
                                    Sbox(5, 0),
                                    Text((controller.myprofile.tier=='')?'티어':controller.myprofile.tier),
                                  ]
                                ),
                                Sbox(0, 5),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Text(controller.myprofile.point,),
                                      Sbox(5, 0),
                                      Image.asset(
                                        "images/point.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ]
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Flexible(
                      //   child: ListView.builder(itemCount: 10,
                      //     scrollDirection: Axis.vertical,
                      //     itemBuilder: (context, index) => Container(
                      //       width: double.infinity,
                      //       height: 90,
                      //       margin: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFD1D1D1),
                      //           borderRadius: BorderRadius.circular(10),
                      //           border: Border.all(
                      //             width:1,
                      //             color: Colors.grey,
                      //           )),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Image.network(//프로필 사진
                      //             controller.myprofile.image,
                      //             fit: BoxFit.fitHeight,
                      //           ),
                      //           Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 Text(controller.myprofile.nick),
                      //                 Row(
                      //                   children: [
                      //                     Image.asset(//랭크 사진
                      //                       "images/point.png",
                      //                       width: 20,
                      //                       height: 20,
                      //                     ),
                      //                     Text(controller.myprofile.tier),
                      //                     //Text(controller.myprofile.point,),
                      //                     Image.asset(
                      //                       "images/point.png",
                      //                       width: 20,
                      //                       height: 20,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ]
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   )
                      // )
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  // Widget list1(){
  //   return SingleChildScrollView(
  //     physics: BouncingScrollPhysics(),
  //     scrollDirection: Axis.horizontal,
  //     child: Container(
  //       child: FittedBox(
  //         fit: BoxFit.fill,
  //         alignment: Alignment.topCenter,
  //         child: Row(
  //           children: [
  //             for(var i=0; i<10;i++)
  //               profileBox1(),
  //           ],
  //         )
  //       )
  //     ),
  //   );
  // }
  //
  // Widget list2(){
  //   return SingleChildScrollView(
  //     physics: BouncingScrollPhysics(),
  //     scrollDirection: Axis.vertical,
  //     child: Container(
  //         child: FittedBox(
  //             fit: BoxFit.fill,
  //             alignment: Alignment.topCenter,
  //             child: Column(
  //               children: [
  //                 for(var i=0; i<10;i++)
  //                   profileBox2(),
  //               ],
  //             )
  //         )
  //     ),
  //   );
  // }

  // Widget profileBox1(){
  //   return              Container(
  //       width: 150,
  //       margin: EdgeInsets.only(right: 20),
  //       height: 180,
  //       decoration: BoxDecoration(color: Colors.cyan,
  //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text('프로필 사진'),
  //           Text('닉네임'),
  //           Row(
  //             children: [
  //               Text('랭크 이미지'),
  //               Text('랭크'),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text('포인트'),
  //               Text('포인트 이미지'),
  //             ],
  //           )
  //         ],
  //       )
  //   );
  // }

  // Widget profileBox2(){
  //   return Container(
  //     width: double.infinity,
  //       height: 200,
  //       margin: EdgeInsets.only(right: 20),
  //       decoration: BoxDecoration(color: Color(0xFFD1D1D1),
  //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text('프로필 사진'),
  //           Text('닉네임'),
  //           Row(
  //             children: [
  //               Text('랭크 이미지'),
  //               Text('랭크'),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text('포인트'),
  //               Text('포인트 이미지'),
  //             ],
  //           )
  //         ],
  //       )
  //  );
  //}
}
