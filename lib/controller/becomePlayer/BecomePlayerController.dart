import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';

class BecomePlayerController extends GetxController {
  //포인트
  TextEditingController pointController = TextEditingController();
  //자기소개
  TextEditingController introductionController = TextEditingController();
  //플레이스타일
  TextEditingController playStyleController = TextEditingController();
  RxBool writeFinish = false.obs;

  //프로필 사진
  var selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      update();
    } else {}
  }

  void isFinish() {
    writeFinish(pointController.text != '' &&
        selectedImagePath.value != '' &&
        playStyleController.text != '' &&
        introductionController.text != '');
  }

  //---------------------------2페이지-------------------------
  RxBool writeFinish2 = false.obs;
  //티어
  final tierList = [
    '언랭크',
    '아이언',
    '브론즈',
    '실버',
    '골드',
    '플래티넘',
    '다이아',
    '마스터',
    '그랜드 마스터',
    '챌린저'
  ].obs;
  RxString selected = "언랭크".obs;

  //성별
  List gender = ['남자', '여자'];
  RxList isSelectedGender = [false.obs, false.obs].obs;

  Future checkGender(var i) async {
    //하나만 선택
    if (isSelectedGender[i] == true) {
      isSelectedGender[i](false);
    } else {
      isSelectedGender[0](false);
      isSelectedGender[1](false);
      isSelectedGender[i](true);
    }
  }

  void isFinish2() {
    writeFinish2(selected.value != '' &&
        (isSelectedGender.value[0].value || isSelectedGender.value[1].value));
    log(isSelectedGender.value[0].value.toString());
  }
  // //포지션
  // List position = ['탑', '정글', '미드', '원딜', '서폿'];
  // RxList isSelectedPosition =
  //     [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  //
  // Future checkPosition(var i) async {
  //   //여러개 선택 가능
  //   if (isSelectedPosition[i] == true) {
  //     isSelectedPosition[i](false);
  //   } else {
  //     isSelectedPosition[i](true);
  //   }
  // }
  //
  // //닉네임
  // TextEditingController nickController = TextEditingController();
  //
  // RxBool checkNickDup = false.obs;
  // Future checkDuplicated() async {
  //   checkNickDup(true);
  // }

  Future Player() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var player = await http.post(Uri.parse(urlBase + 'api/player'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'jwtAccessToken': jwtaccessToken
        },
        body: jsonEncode(<String, dynamic>{
          'userIndex': userId,
          'gender': (isSelectedGender.value[0].value) ? 1 : 2,
          'introduction': introductionController.text,
          'playStyle': playStyleController.text,
          'tier': selected.value,
          'price': pointController.text,
        }));
    Map re = jsonDecode(player.body);
    log(re.toString());
    if (player.statusCode == 1000) {
      // player = Player1(
      //     image: re['profilePhotoUrl'],
      //     isPlayer: re['isPlayer'],
      //     nick: re['nickname'],
      //     tier: '',
      //     position: [],
      //     playStyle: '',
      //     introduce: '',
      //     isOn: true,
      //     star: 0,
      //     reviews: []);
      Get.back();
    }
  }
}