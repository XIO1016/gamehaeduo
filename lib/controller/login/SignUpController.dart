import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool checkNickDup = false.obs;
  List position = ['탑', '정글', '미드', '원딜', '서폿'];
  RxList isSelected =
      [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  TextEditingController nickController = TextEditingController();
  Future checkDuplicated() async {
    checkNickDup(true);
    print(checkNickDup);
  }

  Future checkposition(int i) async {
    if (isSelected[i] == true) {
      isSelected[i](false);
    } else {
      isSelected[i](true);
    }
    print(isSelected);
  }

  ischeckedposition() {
    for (int i = 0; i < 5; i++) {
      if (isSelected[i] == true) {
        return true;
      }
    }
    return false;
  }
}
