import 'dart:convert';
import 'dart:developer';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/controller/message/messageController.dart';
import 'package:cau_gameduo/controller/myPage/MyPageController.dart';
import 'package:cau_gameduo/controller/myPage/settingController.dart';
import 'package:cau_gameduo/controller/requestDuo/requestDuoController.dart';
import 'package:cau_gameduo/controller/searchDuo/seachDuoController.dart';
import 'package:cau_gameduo/controller/home/homePageController.dart';
import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../components/messagePopUp.dart';
import '../../http/url.dart';
import '../../page/app.dart';


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
    Map<String, dynamic> re = jsonDecode(utf8.decode(login.bodyBytes));

    log(re.toString());
    if (re['code'] == 1000) {
      Map result = re['result'];
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


      profile.image = result['profilePhotoUrl']!;
      profile.isPlayer = (result['isPlayer'] == 'N') ? false : true;
      profile.nick = result['nickname']!;
      profile.price = result['point'];

      if (profileRe['code'] == 1000) {
        if (profile.isPlayer) {
          profile.tier = profileRe['result']['tier'];
          profile.playStyle = profileRe['result']['playStyle'];
          profile.introduce = profileRe['result']['introduction'];
          profile.star = profileRe['result']['rating'];
        }
        profile.isOn = (profileRe['result']['playerProfileStatus'] == 'A') ? true : false;
        SettingController.to.on(profile.isOn);

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
        // MyPageController.to.getProfile();
        RequestDuoController.to.getRequestDuo();
        RequestDuoController.to.getRequestedDuo();
        profileController.to.getReviews();
        // profileController.to.getProfile();


        await homePageController.to.gethomePageduoProfile();
        await homePageController.to.gethomePageduoProfileVertical();
        Get.back();
        Get.to(App());
      }
    }
    else { //message: '아이디 비밀번호를 다시 확인해주세요.'

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
            message: re['message'],
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
