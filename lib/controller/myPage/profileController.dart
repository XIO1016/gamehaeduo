import 'package:get/get.dart';

class profileController extends GetxController {
  RxString nickname = "".obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    nickname('song');
  }
}
