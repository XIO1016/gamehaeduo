import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BecomePlayerController2 extends GetxController {

  //티어
  final tierList=['언랭크','아이언','브론즈','실버','골드','플래티넘','다이아','마스터','그랜드 마스터','챌린저'].obs;
  var selected = "언랭크".obs;

  //성별
  List gender = ['남자', '여자'];
  RxList isSelectedGender = [false.obs, false.obs].obs;

  Future checkGender(var i) async { //하나만 선택
    if (isSelectedGender[i] == true) {
      isSelectedGender[i](false);
    } else {
      isSelectedGender[0](false);
      isSelectedGender[1](false);
      isSelectedGender[i](true);
    }
  }

  //포지션
  List position = ['탑', '정글', '미드', '원딜', '서폿'];
  RxList isSelectedPosition = [false.obs, false.obs, false.obs, false.obs, false.obs].obs;

  Future checkPosition(var i) async { //여러개 선택 가능
    if (isSelectedPosition[i] == true) {
      isSelectedPosition[i](false);
    } else {
      isSelectedPosition[i](true);
    }
  }

  //닉네임
  TextEditingController nickController = TextEditingController();

  RxBool checkNickDup = false.obs;
  Future checkDuplicated() async {
    checkNickDup(true);
  }

}