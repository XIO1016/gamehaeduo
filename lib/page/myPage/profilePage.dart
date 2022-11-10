import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Color.dart';
import '../../components/SizedBox.dart';

class profilePage extends GetView<profileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '내 프로필',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        children: [
          Stack(clipBehavior: Clip.none, children: [
            Container(
              width: Get.width,
              height: Get.width,
              color: Colors.grey,
            ),
            Positioned(
              top: Get.width - 20,
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '닉네임',
                            style: TextStyle(fontSize: 15),
                          ),
                          Row(
                            children: [
                              (controller.myprofile.isOn)
                                  ? Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.lightGreenAccent),
                                    )
                                  : Container(),
                              Sbox(10, 0),
                              Text(
                                controller.myprofile.nick,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      Sbox(0, 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '티어',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              controller.myprofile.tier,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ]),
                      Sbox(0, 10),
                      const Text(
                        '포지션',
                        style: TextStyle(fontSize: 15),
                      ),
                      Sbox(0, 10),
                      Row(
                        children: List<Widget>.generate(
                            controller.myprofile.position.length, (index) {
                          return Row(
                            children: [
                              Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: maincolor,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    controller.myprofile.position[index],
                                    style: TextStyle(
                                        color: maincolor, fontSize: 15),
                                  ))),
                              Sbox(10, 0)
                            ],
                          );
                        }),
                      ),
                      Sbox(0, 30),
                      Divider(thickness: 1, height: 10, color: Colors.black),
                      Text('ddddddd')
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
