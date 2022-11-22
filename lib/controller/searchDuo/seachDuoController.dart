import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import '../../http/url.dart';
import '../../model/duo.dart';
import '../../page/login/kakao_loginV1.dart';

class searchDuoController extends GetxController {
  static searchDuoController get to => Get.find<searchDuoController>();
  SwiperController cardController = SwiperController();
  RxList duoList = [].obs;
  RxInt duoNum = 0.obs;
  RxInt index = 0.obs;
  RxInt page = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getDuo() async {
    var getduo = await http.get(
        Uri.parse(urlBase +
            'api/player/profiles/column?userIdx=$userId&size=10&page=${page.value}'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(getduo.body);
    log(response.toString());
    if (response['isSuccess']) {
      Map result = response['result'];
      List homePartnerDTO = result['homePartnerDTO'];
      duoNum(duoNum.value + homePartnerDTO.length);
      log('duoNum' + duoNum.value.toString());
      for (int i = 0; i < homePartnerDTO.length; i++) {
        Map j = homePartnerDTO[i];
        Duo a = Duo(
            name: j['playerId'].toString(),
            rank: j['tier'],
            position: ['탑', '정글'],
            image:
                'https://mblogthumb-phinf.pstatic.net/MjAxOTEwMjdfMzIg/MDAxNTcyMTQzMDk1MzIy.vmE4PCbENLckM1qDsOc0gXKV2R2uyVAIPIsLT-YayKEg.YTzw2hKln4nijfDEp3Y5Y22h5kLsBWkexI9UU6d5XMIg.PNG.yunam69/%EC%8A%A4%ED%8F%B0%EC%A7%80%EB%B0%A5.png?type=w800',
            star: j['rating'],
            playStyle: '',
            introduce: '',
            price: j['price']);
        duoList.add(a);
        log(duoList[i].name.toString());
      }
      page.value += 1;
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
          price: 100);
      duoList.add(a);
    }
    duoNum(20);
  }
}
