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
String jwtaccessToken = '';
String userId = '';

class KakaoLogin {
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          var response = await UserApi.instance.loginWithKakaoTalk();
          accessToken = response.accessToken;

          Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
          var userCheck = await http.post(Uri.parse(urlBase + 'api/userCheck'),
              headers: {
                "content-type": "application/json",
                "accept": "application/json",
              },
              body: jsonEncode(<String, String>{
                'accessToken': accessToken,
              }));

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
              Map<String, dynamic> re1 = jsonDecode(login.body);
              log(re1.toString());

              if (login.statusCode == 200) {
                Map result = re1['result'];
                userId = result['userId']!.toString();
                jwtaccessToken = result['jwtAccessToken']!;

                var getprofile = await http.get(
                    Uri.parse(urlBase + 'api/player/profile?userIdx=$userId'),
                    headers: <String, String>{
                      "content-type": "application/json",
                      "accept": "application/json",
                      "jwtAccessToken": jwtaccessToken
                    });

                log(getprofile.statusCode.toString());
                Map profileRe = jsonDecode(getprofile.body);

                profile.image = result['profilePhotoUrl']!;
                profile.isPlayer = (result['isPlayer'] == 'N') ? false : true;
                profile.nick = result['nickname']!;

                if (profileRe['code'] == 1000) {
                  if (profile.isPlayer) {
                    profile.tier = profileRe['result']['tier'];
                    profile.playStyle = profileRe['result']['playStyle'];
                    profile.introduce = profileRe['result']['introduction'];
                    profile.star = profileRe['result']['rating'];
                  }
                  if (profileRe['result']['top'] == 1)
                    profile.position.add('탑');
                  if (profileRe['result']['jungle'] == 1)
                    profile.position.add('정글');
                  if (profileRe['result']['mid'] == 1)
                    profile.position.add('미드');
                  if (profileRe['result']['ad'] == 1)
                    profile.position.add('원딜');
                  if (profileRe['result']['supporter'] == 1)
                    profile.position.add('서포터');

                  Get.back();
                  Get.to(App());
                }
              }
            }
            // else {
            //   var duologin = await http.post(Uri.parse(urlBase + 'api/login'),
            //       headers: <String, String>{
            //         "content-type": "application/json",
            //         "accept": "application/json",
            //       },
            //       body:
            //           jsonEncode(<String, String>{'accessToken': accessToken}));
            //   Get.to(SignUpPage(), arguments: duologin);
            // }
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
