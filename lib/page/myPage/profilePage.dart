import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Color.dart';
import '../../components/SizedBox.dart';

class profilePage extends GetView<profileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                            Text(
                              controller.nickname.value,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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

                            ]),
                        Sbox(0, 10),
                        const Text(
                          '포지션',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
