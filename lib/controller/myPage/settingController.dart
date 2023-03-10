import 'package:cau_gameduo/http/url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../page/login/kakao_loginV1.dart';
import '../login/SignUpController.dart';

class SettingController extends GetxController {

  static SettingController get to => Get.find<SettingController>();
  RxBool on = false.obs;
  onOff() async {
    if (on.value == false) {
      on(true);
    } else {
      on(false);
    }

    var changeStatus = await http.post(
        Uri.parse(
            '${urlBase}api/player/status?userIdx=$userId&status=${on.value}'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    profile.isOn = on.value;
    // Map<String, dynamic> re1 = jsonDecode(changeStatus.body);
    // log(re1.toString());
  }
}
