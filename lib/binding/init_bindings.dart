import 'package:cau_gameduo/controller/home/homePageController.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/controller/becomePlayer/BecomePlayerController.dart';
import 'package:cau_gameduo/controller/myPage/MyPageController.dart';
import 'package:cau_gameduo/controller/myPage/settingController.dart';
import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/controller/bottomNavController.dart';
import 'package:cau_gameduo/controller/searchDuo/seachDuoController.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController(), permanent: true);
    Get.put(BecomePlayerController(), permanent: true);
    Get.put(homePageController(), permanent: true);
    Get.put(MyPageController(), permanent: true);
    Get.put(profileController(), permanent: true);
    Get.put(SettingController(), permanent: true);
    Get.put(BottomNavController(), permanent: true);
    Get.put(searchDuoController(), permanent: true);
  }
}
