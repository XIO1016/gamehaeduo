import 'dart:convert';
import 'dart:developer';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:cau_gameduo/page/login/signUpPage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import '../app.dart';

String accessToken = '';

class KakaoLogin {
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          var response = await UserApi.instance.loginWithKakaoTalk();
          accessToken = response.accessToken;

          var userCheck = await http.post(Uri.parse(urlBase + 'api/userCheck'),
              headers: {
                "content-type": "application/json",
                "accept": "application/json",
              },
              body: jsonEncode(<String, String>{
                'accessToken': accessToken,
              }));
          log('hello');
          Map re = jsonDecode(userCheck.body);

          log(re.toString());
          if (re['code'] == 1000) {
            if (re['result']['isMember']) {
              Get.to(App());
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
