import 'package:get/get.dart';

import '../../model/profile.dart';
import '../login/SignUpController.dart';

class profileController extends GetxController {
  late Profile1 myprofile;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    myprofile = profile;
  }
}
