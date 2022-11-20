import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';
import '../../model/profile.dart';
import '../login/SignUpController.dart';

class homePageController extends GetxController {

  late Profile1 myprofile;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  RxBool closeTopContainer=false.obs;//임시
  var scrollController=ScrollController().obs;

  var data=[].obs; //데이터
  var isLoading=false.obs; //로딩중
  var isRequesting=false.obs; //다음 데이터 유무

  void Init() {
    getData();
    this.scrollController.value.addListener(() {
      if (this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent &&
          this.isRequesting.value) {
        getData();
      }
    });
    super.onInit();
  }

    getData() async{
      isLoading.value=true;
      
      await Future.delayed(Duration(seconds:2));
      
      int offset=data.length;
      var appendData=List<int>.generate(10, (index) => index+1+offset);
      data.addAll(appendData);
      isLoading.value=false;
      isRequesting.value=data.length<10;
    }

    reload() async{
    isLoading.value=true;
    data.clear();

    await Future.delayed(Duration(seconds:2));

    getData();
    }


  Future getProfile() async {
    myprofile = profile;

  }

  Future homePage() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var signup = await http.get(Uri.parse(urlBase + 'api/player/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        );
    Map re = jsonDecode(signup.body);
    log(re.toString());
    if (signup.statusCode == 1000) {
      // profile = Profile1(
      //     image: re['profilePhotoUrl'],
      //     isPlayer: re['isPlayer'],
      //     nick: re['nickname'],
      //     tier: '',
      //     position: [],
      //     playStyle: '',
      //     introduce: '',
      //     isOn: true,
      //     star: 0,
      //     reviews: []);
      Get.back();
    }
  }
}