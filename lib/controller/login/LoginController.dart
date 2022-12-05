import 'dart:convert';
import 'dart:developer';

import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../components/messagePopUp.dart';
import '../../http/url.dart';


class LoginController extends GetxController {

  RxBool checkIdPw = false.obs;
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController nickController = TextEditingController();


  Future Login() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var login = await http.post(Uri.parse(urlBase + 'api/login-id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': idController.text,
          'password': pwController.text,
        }));
    Map re = jsonDecode(login.body);
    log(re.toString());
    if (login.statusCode == 1000) { //message: '요청에 성공하였습니다'
      checkIdPw(true);
      Get.back();
    }
    else if (login.statusCode == 5004) { //message: '아이디 비밀번호를 다시 확인해주세요.'
      checkIdPw(false);
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
            message: '아이디 비밀번호를 다시 확인해주세요.',
            okCallback: () {
              Get.back();
            },
            okmessage: '확인',
            cancelCallback: Get.back,
          ));
    }
  }






  RxBool checkNickDup=false.obs; //오류나서 임시로
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
}
