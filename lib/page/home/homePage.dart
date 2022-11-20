import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/home/homePageController.dart';
import '../../components/SizedBox.dart';

class homePage extends GetView<homePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                "images/logo.png",
                width: 50,
                height: 50,
              ),
              Sbox(10, 0),
              Text('게임해듀오',
                  style: TextStyle(
                    color: maincolor,
                    fontSize: 14,
                  )),
            ],
          )),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(children: [
            const Text('별점이 높은 유저를 만나보세요',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Sbox(0, 5),
            const Text('같이 게임을 즐길 듀오를 구해보세요',
                style: TextStyle(
                  fontSize: 12,
                )),
            Sbox(0, 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                  10,
                  (index) => Container(
                    height: 193,
                    width: 120,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffD1D1D1),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(60),
                            child: Image.network(
                              //프로필 사진
                              controller.myprofile.image,
                            ),
                          ),
                        ),
                        Sbox(0, 5),
                        Text(
                          controller.myprofile.nick,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Sbox(0, 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                //랭크 사진
                                "images/point.png",
                                width: 18,
                                height: 18,
                              ),
                              Sbox(5, 0),
                              Text(
                                '티어',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ]),
                        Sbox(0, 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Text(controller.myprofile.point,),
                              Sbox(5, 0),
                              Image.asset(
                                "images/point.png",
                                width: 18,
                                height: 18,
                              ),
                            ]),
                        Sbox(0, 5)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    10,
                    (index) => Container(
                      width: double.infinity,
                      height: 90,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFd1d1d1),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(15), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(45),
                              child: Image.network(
                                //프로필 사진
                                controller.myprofile.image,
                              ),
                            ),
                          ),
                          Sbox(20, 0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.myprofile.nick,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Sbox(0, 15),
                                Container(
                                  width: 220,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            //랭크 사진
                                            "images/point.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text('  플레티넘'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('300 PT  '),
                                          Image.asset(
                                            "images/point.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ))
          ]),
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
