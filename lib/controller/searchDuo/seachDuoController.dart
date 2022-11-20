import 'dart:developer';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import '../../model/duo.dart';

class searchDuoController extends GetxController {
  SwiperController cardController = SwiperController();
  RxList duoList = [].obs;
  RxInt duoNum = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getDuo();
    log(duoList.toString());
  }

  getDuo() {
    duoNum(10);
    for (int i = 0; i < 10; i++) {
      Duo a = Duo(
        name: i.toString(),
        rank: '플레티넘',
        position: ['탑', '정글'],
        image:
            'https://mblogthumb-phinf.pstatic.net/MjAxOTEwMjdfMzIg/MDAxNTcyMTQzMDk1MzIy.vmE4PCbENLckM1qDsOc0gXKV2R2uyVAIPIsLT-YayKEg.YTzw2hKln4nijfDEp3Y5Y22h5kLsBWkexI9UU6d5XMIg.PNG.yunam69/%EC%8A%A4%ED%8F%B0%EC%A7%80%EB%B0%A5.png?type=w800',
        star: 4.5,
        playStyle: '즐겁게',
        introduce: '안녕하세요',
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
          },
        ],
      );
      duoList.add(a);
    }
  }

  updateDuo() {
    for (int i = 10; i < 20; i++) {
      Duo a = Duo(
        name: i.toString(),
        rank: '플레티넘',
        position: ['탑', '정글'],
        image:
            'https://mblogthumb-phinf.pstatic.net/MjAxOTEwMjdfMzIg/MDAxNTcyMTQzMDk1MzIy.vmE4PCbENLckM1qDsOc0gXKV2R2uyVAIPIsLT-YayKEg.YTzw2hKln4nijfDEp3Y5Y22h5kLsBWkexI9UU6d5XMIg.PNG.yunam69/%EC%8A%A4%ED%8F%B0%EC%A7%80%EB%B0%A5.png?type=w800',
        star: 4.5,
        playStyle: '즐겁게',
        introduce: '안녕하세요',
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
          },
        ],
      );
      duoList.add(a);
    }
    duoNum(20);
  }
}
