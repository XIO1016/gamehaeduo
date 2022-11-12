import 'dart:convert';
import 'dart:developer';

import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../components/messagePopUp.dart';
import '../../http/url.dart';
import '../../model/profile.dart';
import '../../page/app.dart';

Profile1 profile = Profile1(
    image: '',
    nick: '',
    tier: '',
    position: [],
    playStyle: '',
    introduce: '',
    isOn: true,
    isPlayer: false,
    star: 0,
    reviews: []);

class SignUpController extends GetxController {
  RxBool checkNickDup = false.obs;
  List position = ['탑', '정글', '미드', '원딜', '서폿'];
  RxList isSelected =
      [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  TextEditingController nickController = TextEditingController();

  Future checkDuplicated() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var checkdup = await http.get(
        Uri.parse(
            urlBase + 'api/nickname/dupli?nickname=${nickController.text}'),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
    Map re = jsonDecode(checkdup.body);
    if (re['isSuccess'] == false) {
      checkNickDup(false);
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: '이미 사용중인 닉네임입니다.',
                okCallback: () {
                  Get.back();
                },
                okmessage: '확인',
                cancelCallback: Get.back,
              ));
    } else {
      checkNickDup(true);
      Get.back();
    }
  }

  Future checkposition(int i) async {
    if (isSelected[i] == true) {
      isSelected[i](false);
    } else {
      isSelected[i](true);
    }
    print(isSelected);
  }

  ischeckedposition() {
    for (int i = 0; i < 5; i++) {
      if (isSelected[i] == true) {
        return true;
      }
    }
    return false;
  }

  Future SignUp() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var signup = await http.post(Uri.parse(urlBase + 'api/signUp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'accessToken': accessToken,
          'nickname': nickController.text,
          'top': (isSelected[0].value) ? 1 : 0,
          'jungle': (isSelected[1].value) ? 1 : 0,
          'mid': (isSelected[2].value) ? 1 : 0,
          'ad': (isSelected[3].value) ? 1 : 0,
          'supporter': (isSelected[4].value) ? 1 : 0,
        }));
    Map re = jsonDecode(signup.body);
    log(re.toString());
    if (signup.statusCode == 200) {
      profile = Profile1(
          image: re['profilePhotoUrl'],
          isPlayer: re['isPlayer'],
          nick: re['nickname'],
          tier: '',
          position: [],
          playStyle: '',
          introduce: '',
          isOn: true,
          star: 0,
          reviews: []);
      Get.back();
      Get.to(App());
    }
  }
}
