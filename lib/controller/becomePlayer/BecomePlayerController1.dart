import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BecomePlayerController1 extends GetxController{

  //포인트
  TextEditingController pointController = TextEditingController();

  //프로필 사진
  var selectedImagePath=''.obs;

  void getImage(ImageSource imageSource) async{
    final pickedFile=await ImagePicker().pickImage(source: imageSource);
    if(pickedFile!=null){
      selectedImagePath.value=pickedFile.path;
      update();
    }
    else{}
  }

}