import 'dart:convert';
import 'dart:developer';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:cau_gameduo/page/login/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import '../../controller/login/SignUpController.dart';
import '../../http/url.dart';
import '../app.dart';
import '../../model/profile.dart';

String accessToken = '';

class KakaoLogin {
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          var response = await UserApi.instance.loginWithKakaoTalk();
          accessToken = response.accessToken;

          Get.dialog(Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
          var userCheck = await http.post(Uri.parse(urlBase + 'api/userCheck'),
              headers: {
                "content-type": "application/json",
                "accept": "application/json",
              },
              body: jsonEncode(<String, String>{
                'accessToken': accessToken,
              }));

          Get.back();
          Map re = jsonDecode(userCheck.body);

          log(re.toString());
          if (re['code'] == 1000) {
            if (re['result']['isMember']) {
              log('eeeeeeeeeeeeeee');
              var login = await http.post(Uri.parse(urlBase + 'api/login'),
                  headers: <String, String>{
                    "content-type": "application/json",
                    "accept": "application/json",
                  },
                  body:
                      jsonEncode(<String, String>{'accessToken': accessToken}));
              Map re1 = jsonDecode(login.body);
              log(re1.toString());

              if (login.statusCode == 200) {
                profile.image = re1['result']['profilePhotoUrl'];
                profile.isPlayer =
                    (re1['result']['isPlayer'] == 'N') ? false : true;
                profile.nick = re1['result']['nickname'];

                log('go');
                // Get.back();
                Get.to(App());
              }
            } else {
              var duologin = await http.post(Uri.parse(urlBase + 'login'),
                  body: jsonEncode(<String, String>{
                    'accessToken': accessToken,
                  }));
              Get.to(SignUpPage(), arguments: duologin);
            }
          } else if (userCheck.statusCode == 2001) {
            log('RESEND PLEASE');
          } else {
            return false;
          }

          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }
}
