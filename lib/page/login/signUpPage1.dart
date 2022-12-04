import 'dart:developer';

import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:cau_gameduo/page/login/signUpPage2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/SizedBox.dart';

class SignUpPage1 extends GetView<SignUpController> {
  const SignUpPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
            bottomSheet: (controller.pwCheckController.text.length > 0 &&
                controller.idController.text.length > 0 &&
                controller.pwController.text.length > 0)
              ? GestureDetector(
              onTap: () {
            if(controller.pwCheckController.text != controller.pwCheckController.text){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('비밀번호를 다시 확인해주세요.'),
                          ],
                        ),
                      ),
                    );});
            }else{

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpPage2()));

            }
          },
          child: Container(
            width: Get.width,
            height: 60,
            color: maincolor,
            child: const Center(
              child: Text(
                '다음',
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
              '다음',
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
                        controller: controller.idController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: maincolor)),
                          suffixIcon: (controller.checkIdDup.value)
                              ? Icon(
                            Icons.check,
                            color: maincolor,
                          )
                              : null,
                          hintText: "영어, 숫자 조합 6-10자리",
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Color(0xff727272)),
                        ),
                        validator: (value) {
                          return controller.validateId(value!);
                        },
                      ),
                    ),
                    Sbox(10, 0),
                    GestureDetector(
                      onTap: () {
                        controller.checkIdDuplicated();
                      },
                      child: Container(
                        width: 80,
                        height: 43,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: (controller.checkIdDup.value)
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
                        obscureText: true,
                        cursorColor: maincolor,
                        controller: controller.pwController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: maincolor)),
                          hintText: "영어, 숫자 조합 6-10자리",
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Color(0xff727272)),
                        ),
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
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
                        obscureText: true,
                        cursorColor: maincolor,
                        controller: controller.pwCheckController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: maincolor)),
                          suffixIcon: (controller.pwCheck.value)
                              ? Icon(
                            Icons.check,
                            color: maincolor,
                          )
                              : null,
                          hintText: "비밀번호 확인",
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Color(0xff727272)),
                        ),
                        validator: (value) {
                          return controller.validatePasswordCheck(value!);
                        },
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
