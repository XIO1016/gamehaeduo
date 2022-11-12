import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{

  RxBool on=false.obs;
  Future onOff() async{
    if(on.value==false){
      on(true);
    } else on(false);
  }
}