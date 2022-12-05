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
    if (re['isSuccess'] == false) {
      checkIdPw(false);
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
            message: '아이디 비밀번호를 확인해주세요!',
            okCallback: () {
              Get.back();
            },
            okmessage: '확인',
            cancelCallback: Get.back,
          ));
    } else {
      checkIdPw(true);
      Get.back();
    }
  }




}
