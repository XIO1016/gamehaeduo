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
  RxBool on = false.obs;
  void toggle() => on.value = on.value ? false : true;

  Profile1 myprofile = profileController.to.myprofile;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    myprofile = profile;
  }
}
