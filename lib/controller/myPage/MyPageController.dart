import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController{

  RxBool on=false.obs;
  void toggle() => on.value = on.value ? false : true;

  RxBool isPicture=false.obs;

  void Picture(){
    if(isPicture==false){
      isPicture=true.obs;
    }
    else isPicture=false.obs;
  }
}