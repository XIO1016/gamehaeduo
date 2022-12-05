import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import '../../model/profile.dart';
import '../login/SignUpController.dart';

class MyPageController extends GetxController {

  static MyPageController get to => Get.find<MyPageController>();
  RxBool on = false.obs;
  void toggle() => on.value = on.value ? false : true;
int requestedDuoNum=0;
  int requestDuoNum=0;
  late Profile1 myprofile;
  // Profile1 myprofile = profileController.to.myprofile;
  @override
  void onInit() {
    super.onInit();
    // getProfile();
  }

  Future getProfile() async {
    myprofile = profile;
  }

  getRequestDuoNum() async{
    var getRequestDuoNumRequest = await http.get(
        Uri.parse(
            '${urlBase}api/duo/num?userIdx=$userId'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getRequestDuoNumRequest.bodyBytes));
    Map result=response['result'];
    requestedDuoNum=result['requestedDuoNum'];
    requestDuoNum=result['requestDuoNum'];
    profile.price= result['point'];

  }
}
