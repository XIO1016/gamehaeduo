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
  getDuoRefresh() async{
    duoList([]);
    page(0);
    index(0);
    duoNum(0);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    await getDuo();
    Get.back();
  }

  getDuo() async {
    var getduo = await http.get(
        Uri.parse(
            '${urlBase}api/duo/search?userIdx=$userId&size=10&page=${page.value}'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getduo.bodyBytes));
    // log(response.toString());
    if (response['isSuccess']) {
      List result = jsonDecode(jsonEncode(response['result']));

      duoNum(duoNum.value + result.length);
      // log('duoNum' + duoNum.value.toString());
      for (int i = 0; i < result.length; i++) {
        Map j = result[i];
        String nick = j['nickname'];

        Duo a = Duo(
          status: -1,
          duoId: j['duoId'],
            name: nick,
            rank: j['tier'],
            position: [],
            image: j['profilePhotoUrl'],
            star: j['rating'],
            playStyle: j['playStyle'],
            introduce: j['introduction'],
            price: j['price']);

        if (j['top'] == 1) a.position.add('탑');
        if (j['jungle'] == 1) a.position.add('정글');
        if (j['mid'] == 1) a.position.add('미드');
        if (j['ad'] == 1) a.position.add('원딜');
        if (j['supporter'] == 1) a.position.add('서포터');
        duoList.add(a);
        // log(duoList[i].name.toString());
      }
      page.value += 1;
    }
  }
}
