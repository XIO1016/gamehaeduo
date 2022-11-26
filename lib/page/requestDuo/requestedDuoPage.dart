import 'dart:io';
import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/requestingDuo/requestingDuoController.dart';
import '../../components/requestDuoPopUp.dart';
import '../../components/SizedBox.dart';

class RequestingDuoPage extends GetView<RequestingDuoController> {
  const RequestingDuoPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Color(0xff0F9F9F9),
              appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(
                        Icons.keyboard_arrow_left_rounded, color: blackcolor),
                    onPressed: () => Get.back(),
                  ),
                  titleSpacing: 0,
                  elevation: (controller.temp==0)?0:0,
                  title: const Text(
                    '요청한 듀오',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  bottom: TabBar(
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: maincolor),
                        insets: EdgeInsets.symmetric(horizontal:30.0),
                      ),
                      tabs: [
                        Tab(text: '전체',),
                        Tab(text: '수락대기',),
                        Tab(text: '진행중',),
                        Tab(text: '과거',)]
                  )
              ),
              body: TabBarView(
                children: [
                  //전체
                  SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            children:[
                              requestBox(context),
                              requestBox(context),
                            ]
                        )
                    ),
                  ),
                  //수락대기
                  SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            children:[
                              requestBox(context),
                              requestBox(context),
                            ]
                        )
                    ),
                  ),
                  //진행중
                  SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            children:[
                              requestBox(context),
                            ]
                        )
                    ),
                  ),
                  //과거
                  SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            children:[
                              requestBox(context),
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget requestBox(BuildContext context){
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children:[
          Text('신청 수락 대기중',
          style: TextStyle(
            color: Color(0xff14BC57),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          )),
          // Text('진행중',
          //     style: TextStyle(
          //       color: maincolor,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //     )),
          // Text('듀오 완료',
          //     style: TextStyle(
          //       color: Color(0xff5A5A5A),
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //     )),
          // Text('취소',
          //     style: TextStyle(
          //       color: Color(0xff5A5A5A),
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //     )),
          // Text('거절',
          //     style: TextStyle(
          //       color: Color(0xff5A5A5A),
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //     )),
          const Divider(
            thickness: 1,
            color: Color(0xffF0F0F0),
          ),
          Container(
            child: Row(
              children:[
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: Color(0xffD9D9D9),
                  ),
                ),
                Sbox(10, 0),
                Expanded(
                  child: Column(
                    children:[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Expanded(
                            child: Row(
                              children: [
                                Text('전주비빔밥',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )),
                              ],
                            ),
                          ),
                          Container(child: Row(
                            children: [
                              Image.asset(
                                "images/point.png",
                                width: 18,
                                height: 18,
                              ),
                              Sbox(3, 0),
                              Text('1500',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),),
                            ],
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                children: const<TextSpan>[
                                  TextSpan(text: '요청 시간: ',
                                   style: TextStyle(
                                     color: Color(0xff727272),
                                     fontSize: 10,
                                   )),
                                  TextSpan(text: '2022-11-03',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black                                      )),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        children:[
                          Expanded(child: Row(
                            children: [
                              Image.asset(
                                "images/point.png",
                                width: 18,
                                height: 18,
                              ),
                              Sbox(3, 0),
                              Text('플레티넘',
                                  style: TextStyle(
                                    color: Color(0xff14BC57),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffF0F0F0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed:(){RejectRequestPopUp(context);},
                child: Text('거절',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),),
                style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    side: BorderSide(color: Colors.black, width: 0.2),
                    padding: EdgeInsets.only(bottom: 5, left: 25, right: 25)
                ),),
              ElevatedButton(
                onPressed:(){AcceptRequestPopUp(context);},
                child: Text('수락',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: maincolor,
                    padding: EdgeInsets.only(bottom: 5, left: 25, right: 25)
                ),),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     OutlinedButton(
          //       onPressed:(){CancelOngoingPopUp(context);},
          //       child: Text('취소',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 16,
          //         ),),
          //       style: OutlinedButton.styleFrom(
          //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          //           side: BorderSide(color: Colors.black, width: 0.2),
          //           padding: EdgeInsets.only(bottom: 5, left: 25, right: 25)
          //       ),),
          //     ElevatedButton(
          //       onPressed:(){FinishOngoingPopUp(context);},
          //       child: Text('완료',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 16,
          //         ),),
          //       style: OutlinedButton.styleFrom(
          //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          //           backgroundColor: maincolor,
          //           padding: EdgeInsets.only(bottom: 5, left: 25, right: 25)
          //       ),),
          //   ],
          // )
        ],

      ),
    );
  }

}
