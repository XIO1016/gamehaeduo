import 'dart:io';

import 'package:cau_gameduo/controller/message/messageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/messagePopUp.dart';

enum PageName { HOME, FIND, CHAT,LIST, USER }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  Future<void> changeBottomNav(int value, {bool hasGesture = true}) async {
    var page = PageName.values[value];
    switch (page) {
      case PageName.HOME:
        _changePage(value, hasGesture: hasGesture);
        break;
      case PageName.FIND:
        _changePage(value, hasGesture: hasGesture);
        break;
      case PageName.CHAT:
        Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
        await MessageController.to.getAllRooms();
        Get.back();
        _changePage(value, hasGesture: hasGesture);
        break;
      case PageName.LIST:
      case PageName.USER:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: '종료하시겠습니까?',
                okCallback: () {
                  exit(0);
                },
                okmessage: '종료',
                cancelCallback: Get.back,
              ));
      return true;
    } else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      print(bottomHistory);

      return false;
    }
  }
}
