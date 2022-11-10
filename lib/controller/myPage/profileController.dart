import 'package:get/get.dart';

import '../../model/profile.dart';

class profileController extends GetxController {
  late Profile myprofile;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    myprofile = Profile(
        nick: 'song',
        tier: '플레티넘',
        position: ['탑', '정글'],
        playStyle: '음성으로 소통하면서 게임하는걸 좋아해요',
        introduce: '즐겁게 게임했으면 좋겠습니다. 부담없이 연락주세요!',
        isOn: true);
  }
}
