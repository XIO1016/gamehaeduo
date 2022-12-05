import 'dart:developer';

import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/page/login/loginPage.dart';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/SizedBox.dart';

class SignUpPage2 extends GetView<SignUpController> {
  const SignUpPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomSheet: (controller.checkNickDup.value == true &&
                controller.ischeckedposition() == true)
            ? GestureDetector(
                onTap: () {
                  controller.SignUpId();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => LoginPage())); //회원가입 한 후 로그인 페이지로 이동?
                },
                child: Container(
                  width: Get.width,
                  height: 60,
                  color: maincolor,
                  child: const Center(
                    child: Text(
                      '완료',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            : Container(
                width: Get.width,
                height: 60,
                color: const Color(0xffE9E9E9),
                child: const Center(
                  child: Text(
                    '완료',
                    style: TextStyle(color: Color(0xffB0B0B0), fontSize: 16),
                  ),
                ),
              ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
            onPressed: () => Get.back(),
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '회원가입',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sbox(0, 10),
                const Text(
                  '닉네임',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Sbox(0, 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: maincolor,
                        controller: controller.nickController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: maincolor)),
                          suffixIcon: (controller.checkNickDup.value)
                              ? Icon(
                                  Icons.check,
                                  color: maincolor,
                                )
                              : null,
                          hintText: "영어, 한글, 숫자 조합 2-10자리",
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Color(0xff727272)),
                        ),
                      ),
                    ),
                    Sbox(10, 0),
                    GestureDetector(
                      onTap: () {
                        controller.checkDuplicated();
                      },
                      child: Container(
                        width: 80,
                        height: 43,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: (controller.checkNickDup.value)
                                    ? maincolor
                                    : const Color(0xffAFAFAF))),
                        child: const Center(child: Text('중복확인')),
                      ),
                    ),
                  ],
                ),
                Sbox(0, 50),
                Row(
                  children: [
                    const Text(
                      '포지션',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Sbox(5, 0),
                    const Text(
                      '(중복 선택)',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff727272)),
                    )
                  ],
                ),
                Sbox(0, 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [nonSelected(0), nonSelected(1)],
                ),
                Sbox(0, 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [nonSelected(2), nonSelected(3)],
                ),
                Sbox(0, 10),
                nonSelected(4)
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget nonSelected(int i) {
    return GestureDetector(
      onTap: () => controller.checkposition(i),
      child: Container(
        width: Get.width / 2 - 30,
        height: 50,
        decoration: (controller.isSelected[i] == true)
            ? BoxDecoration(
                color: Colors.white, border: Border.all(color: maincolor))
            : const BoxDecoration(color: Color(0xffF4F4F4)),
        child: Center(
            child: Text(
          controller.position[i],
          style: TextStyle(
            fontSize: 16,
            color: (controller.isSelected[i] == true)
                ? maincolor
                : const Color(0xffB4B4B4),
          ),
        )),
      ),
    );
  }
}
