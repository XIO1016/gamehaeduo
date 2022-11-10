import 'package:cau_gameduo/controller/homePageController.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/controller/becomePlayer/BecomePlayerController1.dart';
import 'package:cau_gameduo/controller/becomePlayer/BecomePlayerController2.dart';

import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController(), permanent: true);
    Get.put(BecomePlayerController1(), permanent: true);
    Get.put(BecomePlayerController2(), permanent: true);
    Get.put(homePageController(), permanent: true);
  }
}
