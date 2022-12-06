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
    isOn: false,
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
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var checkdup = await http.get(
        Uri.parse(
            '${urlBase}api/nickname/dupli?nickname=${nickController.text}'),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
    Map re = jsonDecode(utf8.decode(checkdup.bodyBytes));
    if (re['isSuccess'] == false) {
      checkNickDup(false);
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message:re['message'],
                okCallback: () {
                  Get.back();
                  Get.back();

                },
                okmessage: '확인',
                cancelCallback: () {
                  Get.back();
                  Get.back();

                },
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
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    late var signup;
    if (type.value == 1) {
      signup = await http.post(Uri.parse('${urlBase}api/signUp'),
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
      signup = await http.post(Uri.parse('${urlBase}api/signUp-id'),
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

      Get.back();
      Get.to(App());

  }

  Future SignUpId() async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var signup = await http.post(Uri.parse('${urlBase}api/signUp-id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': idController.text,
          'password': pwController.text,
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

      Get.back();
      Get.back();
      Get.back();
    }
  }

  Future checkIdDuplicated() async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var checkdup = await http.get(
        Uri.parse('${urlBase}api/id/dupli?id=${idController.text}'),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
        Map re = jsonDecode(utf8.decode(checkdup.bodyBytes));
    log(checkdup.statusCode.toString());
    if (re['isSuccess'] == false) {
      checkIdDup(false);
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: re['message'],
                okCallback: () {
                  Get.back();
                  Get.back();
                },
                okmessage: '확인',
                cancelCallback:  () {
                  Get.back();
                  Get.back();
                },
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
