import 'dart:io';
import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage1.dart';
import 'package:cau_gameduo/page/myPage/profilePage.dart';
import 'package:cau_gameduo/page/requestDuo/requestDuoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/myPage/MyPageController.dart';
import '../../components/SizedBox.dart';
import 'package:cau_gameduo/page/myPage/settingPage.dart';
import 'dart:math' as math;

import '../../controller/login/SignUpController.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sbox(0, 10),
                GestureDetector(
                  onTap: () => Get.to(profilePage()),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey,
                          child: Image.network(
                            profile.image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Sbox(20, 0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.nick,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Sbox(0, 5),
                          (profile.price == -1)
                              ? SizedBox()
                              : Row(
                                  children: [
                                    Text(
                                      profile.price.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Sbox(10, 0),
                                    Image.asset(
                                      "images/point.png",
                                      width: 25,
                                      height: 25,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      Expanded(child: Sbox(10, 0)),
                      Icon(Icons.navigate_next, size: 50, color: Colors.grey),
                      Sbox(10, 0),
                    ],
                  ),
                ),
                Sbox(0, 30),

                //요청 듀오
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: maincolor),
                    borderRadius: BorderRadius.all(Radius.circular(
                            20.0) //                 <--- border radius here
                        ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 5.0,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap:()=>Get.to(()=>RequestDuoPage()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              controller.requestedDuoNum.toString(),
                              style: TextStyle(fontSize: 50),
                            ),
                            const Text(
                              "요청받은 듀오",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>Get.to(()=>RequestDuoPage()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                               controller.requestDuoNum.toString(),
                              style: TextStyle(fontSize: 50),
                            ),
                            const Text("요청한 듀오",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Sbox(0, 10),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    leading: Icon(Icons.headphones),
                    title: Text('플레이어 되기 (프로필 등록)',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(BecomePlayerPage1());
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    leading: Icon(Icons.settings),
                    title: Text('설정',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(SettingPage());
                    },
                  ),
                ),
              ],
            ),
            Sbox(0, 20),
          ],
        ),
      ),
    );
  }
}
