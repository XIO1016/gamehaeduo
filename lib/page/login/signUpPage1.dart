import 'dart:developer';

import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/SizedBox.dart';

class SignUpPage1 extends GetView<SignUpController> {
  const SignUpPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        bottomSheet: (controller.checkNickDup.value == true &&
            controller.ischeckedposition() == true)
            ? GestureDetector(
          onTap: () {
            controller.SignUp();
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
                  '아이디',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
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
                          hintText: "영어, 숫자 조합 6-10자리",
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
                Sbox(0, 30),
                const Text(
                  '비밀번호',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
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
                          hintText: "영어, 숫자 조합 6-10자리",
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Color(0xff727272)),
                        ),
                      ),
                    ),
                    Sbox(10, 0),
                  ],
                ),
                Sbox(0, 30),
                const Text(
                  '비밀번호 확인',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
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
                          hintText: "비밀번호 확인",
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Color(0xff727272)),
                        ),
                      ),
                    ),
                    Sbox(10, 0),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

}
