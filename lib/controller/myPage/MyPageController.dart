import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import '../../model/profile.dart';
import '../login/SignUpController.dart';



class MyPageController extends GetxController{

  RxBool on=false.obs;
  void toggle() => on.value = on.value ? false : true;

  late Profile1 myprofile;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    myprofile = profile;
  }

  Future Player() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var player = await http.post(Uri.parse(urlBase + 'api/player'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'jwtAccessToken': jwtaccessToken
        },
        body: jsonEncode(<String, dynamic>{

        }));
    //Map re = jsonDecode(player.body);
    //log(re.toString());
    if (player.statusCode == 1000) {
//       profile = Profile1(
//           image: re['message']['profilePhotoUrl'],
// );
      Get.back();
    }
  }


}