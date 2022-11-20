import 'dart:io';
import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage2.dart';
import 'package:cau_gameduo/controller/becomePlayer/BecomePlayerController.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/SizedBox.dart';

class BecomePlayerPage1 extends GetView<BecomePlayerController> {
  const BecomePlayerPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
            onPressed: () => Get.back(),
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '플레이어 되기(1/2)',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          //**나중에 FORM으로 감싸기
          padding: EdgeInsets.all(20),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '포인트 가격 설정',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Sbox(0, 10),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: TextFormField(
                        maxLength: 5, //**최대 99999원
                        // ->maxLength 대신 input>x이면 빨간 경고 주고 입력 막기?
                        // ->maxLength는 5로 두고 x를 99999 이하로?
                        cursorColor: maincolor,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: maincolor),
                          ),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.number,
                        controller: controller.pointController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ], //숫자만 입력 가능
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
                Sbox(0, 20),

                //프로필 사진
                const Text(
                  '프로필 사진',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Sbox(0, 10),
                GestureDetector(
                  onTap: () {
                    controller.getImage(ImageSource.camera);
                  },
                  child: picture(),
                ),
                Sbox(0, 20),

                //자기 소개 **글자수 제한 정하기
                const Text(
                  '자기 소개',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Sbox(0, 10),
                SizedBox(
                  width: Get.width,
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: maincolor),
                      ), //선택했을 때 색 파랗게 해봄...
                    ),
                  ),
                ),
                Sbox(0, 20),

                //플레이 스타일 **글자수 제한 정하기
                const Text(
                  '플레이 스타일',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Sbox(0, 10),
                SizedBox(
                  width: Get.width,
                  child: const TextField(
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),

        //**언제 파랗게 될지(필수 선택) 정하기
        bottomSheet: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BecomePlayerPage2()));
          },
          child: Container(
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
        ),
      ),
    );
  }

  //프로필 사진 **사진 업로드 안됨...흑...
  Widget picture() {
    return GestureDetector(
      onTap: () {
        controller.getImage(ImageSource.gallery);
      },
      child: Container(
        width: 150,
        height: 130,
        decoration: (controller.selectedImagePath.value == '')
            ? const BoxDecoration(color: Color(0xffF4F4F4))
            : BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(controller.selectedImagePath.value))),
              ),
        child: Center(
            child: (controller.selectedImagePath.value == '')
                ? const Icon(Icons.camera)
                : null),
      ),
    );
  }
}
