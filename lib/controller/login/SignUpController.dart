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
import 'package:cau_gameduo/controller/message/messageController.dart';
import 'package:cau_gameduo/controller/myPage/MyPageController.dart';
import 'package:cau_gameduo/controller/requestDuo/requestDuoController.dart';
import 'package:cau_gameduo/controller/searchDuo/seachDuoController.dart';
import 'package:cau_gameduo/controller/home/homePageController.dart';
import 'package:cau_gameduo/controller/myPage/profileController.dart';


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
    reviews: [],
    price: -1);

class SignUpController extends GetxController {
  RxInt type = 0.obs;
  RxBool checkNickDup = false.obs;
  RxBool checkIdDup = false.obs;
  RxBool pwCheck = false.obs;
  List position = ['탑', '정글', '미드', '원딜', '서폿'];
  RxList isSelected =
      [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  TextEditingController nickController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();
  RxBool isFinish = false.obs;

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
    late var signup;
    if (type.value == 1) {
      signup = await http.post(Uri.parse(urlBase + 'api/signUp'),
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
    } else {
      signup = await http.post(Uri.parse(urlBase + 'api/signUp-id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': idController.text,
            'password':pwController.text,
            'accessToken': accessToken,
            'nickname': nickController.text,
            'top': (isSelected[0].value) ? 1 : 0,
            'jungle': (isSelected[1].value) ? 1 : 0,
            'mid': (isSelected[2].value) ? 1 : 0,
            'ad': (isSelected[3].value) ? 1 : 0,
            'supporter': (isSelected[4].value) ? 1 : 0,
          }));
    }

    Map re = jsonDecode(signup.body);
    var result= re['message'];
    log(re.toString());
    if (signup.statusCode == 200) {
      profile = Profile1(
          price: result['point'],
          image: result['profilePhotoUrl'],
          isPlayer: result['isPlayer'],
          nick: result['nickname'],
          tier: '',
          position: [],
          playStyle: '',
          introduce: '',
          isOn: true,
          star: 0,
          reviews: []);
      jwtaccessToken= result['jwtRefreshToken'];
      if (result['top'] == 1)
        profile.position.add('탑');
      if (result['jungle'] == 1)
        profile.position.add('정글');
      if (result['mid'] == 1)
        profile.position.add('미드');
      if (result['ad'] == 1)
        profile.position.add('원딜');
      if (result['supporter'] == 1)
        profile.position.add('서포터');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchDuoController.to.getDuo();
      });
      MessageController.to.getAllRooms();
      MyPageController.to.getRequestDuoNum();
      RequestDuoController.to.getRequestDuo();
      RequestDuoController.to.getRequestedDuo();
      profileController.to.getReviews();

      await homePageController.to.gethomePageduoProfile();
      await homePageController.to.gethomePageduoProfileVertical();
      Get.back();
      Get.to(App());
    }
  }

  Future checkIdDuplicated() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var checkdup = await http.get(
        Uri.parse(urlBase + 'api/id/dupli?id=${idController.text}'),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
    Map re = jsonDecode(checkdup.body);
    log(checkdup.statusCode.toString());
    if (re['isSuccess'] == false) {
      checkIdDup(false);
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: '이미 사용중인 아이디입니다.',
                okCallback: () {
                  Get.back();
                },
                okmessage: '확인',
                cancelCallback: Get.back,
              ));
    } else {
      checkIdDup(true);
      Get.back();
    }
  }

  String? validateId(String value) {
    RegExp regex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\w\W]{6,10}$");
    if (value.isEmpty) {
      return '아이디를 입력해주세요';
    } else {
      if (!regex.hasMatch(value)) {
        return '영어, 숫자를 포함한 6~10자를 입력해주세요';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String value) {
    RegExp regex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\w\W]{6,10}$");
    if (value.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else {
      if (!regex.hasMatch(value)) {
        return '영어, 숫자를 포함한 6~10자를 입력해주세요';
      } else {
        return null;
      }
    }
  }

  String? validatePasswordCheck(String value) {
    if (value.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else {
      if (value != pwController.text) {
        return '비밀번호가 일치하지 않습니다!';
      } else {
        pwCheck(true);
        return null;
      }
    }
  }

  writeFinish() {
    isFinish(pwCheckController.text.isNotEmpty &&
        checkIdDup.value &&
        pwController.text.isNotEmpty);
  }
}
