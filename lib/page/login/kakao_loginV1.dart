import 'dart:convert';
import 'dart:developer';
import 'package:cau_gameduo/controller/message/messageController.dart';
import 'package:cau_gameduo/controller/myPage/MyPageController.dart';
import 'package:cau_gameduo/controller/requestDuo/requestDuoController.dart';
import 'package:cau_gameduo/controller/searchDuo/seachDuoController.dart';
import 'package:cau_gameduo/controller/home/homePageController.dart';
import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/page/login/signUpPage2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import '../../controller/login/SignUpController.dart';
import '../../controller/myPage/settingController.dart';
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
              var login = await http.post(Uri.parse(urlBase + 'api/login'),
                  headers: <String, String>{
                    "content-type": "application/json",
                    "accept": "application/json",
                  },
                  body:
                      jsonEncode(<String, String>{'accessToken': accessToken}));
              Map<String, dynamic> re1 =
                  jsonDecode(utf8.decode(login.bodyBytes));
              log(re1.toString());
              if (login.statusCode == 200) {
                Map result = re1['result'];
                log(result.toString());
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
                Map profileRe = jsonDecode(utf8.decode(getprofile.bodyBytes));
                log(profileRe.toString());
                profile.isOn = (result['status'] == 'Active') ? true : false;
                SettingController.to.on(profile.isOn);
                profile.image = result['profilePhotoUrl']!;
                profile.isPlayer = (result['isPlayer'] == 'N') ? false : true;
                profile.nick = result['nickname'];

                profile.price = result['point'];

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
            } else {

              Get.to(SignUpPage2(), arguments: [0]);
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
          var response = await UserApi.instance.loginWithKakaoAccount();
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
              var login = await http.post(Uri.parse(urlBase + 'api/login'),
                  headers: <String, String>{
                    "content-type": "application/json",
                    "accept": "application/json",
                  },
                  body:
                  jsonEncode(<String, String>{'accessToken': accessToken}));
              Map<String, dynamic> re1 =
              jsonDecode(utf8.decode(login.bodyBytes));
              log(re1.toString());
              if (login.statusCode == 200) {
                Map result = re1['result'];
                log(result.toString());
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
                Map profileRe = jsonDecode(utf8.decode(getprofile.bodyBytes));
                log(profileRe.toString());
                profile.isOn = (result['status'] == 'Active') ? true : false;
                SettingController.to.on(profile.isOn);
                profile.image = result['profilePhotoUrl']!;
                profile.isPlayer = (result['isPlayer'] == 'N') ? false : true;
                profile.nick = result['nickname'];

                profile.price = result['point'];

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
            } else {

              Get.to(SignUpPage2(), arguments: [0]);
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
