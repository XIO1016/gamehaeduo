import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController(), permanent: true);
  }
}
