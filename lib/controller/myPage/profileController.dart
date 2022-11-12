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
        isPlayer: true,
        nick: 'song',
        tier: '플레티넘',
        position: ['탑', '정글'],
        playStyle: '음성으로 소통하면서 게임하는걸 좋아해요',
        introduce: '즐겁게 게임했으면 좋겠습니다. 부담없이 연락주세요!',
        isOn: true,
        star: 4.0,
        reviews: [
          {
            'name': '나는야 펭수라네',
            'star': 4.0,
            'review':
                '제가 말이 별로 없는데도 재밌게 잘 끌어주셔서 너무 좋았습니다ㅎㅎ 디코 연결 상태만 좋았으면 훨씬 더 재밌었을 것 같아요!',
            'date': '2022.11.01'
          },
          {
            'name': '나는야 펭수라네',
            'star': 4.0,
            'review':
                '제가 말이 별로 없는데도 재밌게 잘 끌어주셔서 너무 좋았습니다ㅎㅎ 디코 연결 상태만 좋았으면 훨씬 더 재밌었을 것 같아요!',
            'date': '2022.11.01'
          }
        ]);
  }
}
