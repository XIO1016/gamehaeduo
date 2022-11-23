import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';
import '../../model/duo.dart';
import '../../model/profile.dart';
import '../../page/login/kakao_loginV1.dart';
import '../login/SignUpController.dart';

class homePageController extends GetxController {
  static homePageController get to => Get.find<homePageController>();
  List duoList = [];
  RxList duoList2 = [].obs;
  RxInt page = 0.obs;

  RxBool closeTopContainer = false.obs; //임시
  Rx<ScrollController> scrollController = ScrollController().obs;

  var data = [].obs; //데이터
  var isLoading = false.obs; //로딩중
  var hasMore = false.obs;
  var isRequesting = true.obs; //다음 데이터 유무
  @override
  void onInit() {
    scrollController.value.addListener(() {
      print('offset = ${scrollController.value.position}');
      if ((scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent) &&
          isRequesting.value) {
        // if (scrollController.value.position.pixels ==
        //         scrollController.value.position.maxScrollExtent &&
        //     isRequesting.value) {
        getData();
      }
    });
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    page.value += 1;

    await gethomePageduoProfileVertical();

    isLoading(false);
  }

  reload() async {
    isLoading.value = true;
    data.clear();

    getData();
  }

  gethomePageduoProfile() async {
    var getduo = await http.get(
        Uri.parse('${urlBase}api/player/profiles/row?userIdx=$userId'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });

    Map response = jsonDecode(utf8.decode(getduo.bodyBytes));

    log(response.toString());
    if (response['isSuccess']) {
      List result =
          jsonDecode(jsonEncode(response['result']))['homePartnerDTO'];

      for (int i = 0; i < result.length; i++) {
        Map j = result[i];
        String nick = j['userNickname'];

        Duo a = Duo(
            name: nick,
            rank: j['tier'],
            position: [],
            image: j['profilePhotoUrl'],
            star: j['rating'],
            playStyle: '',
            introduce: '',
            price: j['price']);

        duoList.add(a);
        // log(duoList[i].image.toString());
      }
    }
  }

  gethomePageduoProfileVertical() async {
    var getduo = await http.get(
        Uri.parse(
            '${urlBase}api/player/profiles/column?userIdx=$userId&size=10&page=${page.value}'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });

    Map response = jsonDecode(utf8.decode(getduo.bodyBytes));

    if (response['isSuccess']) {
      List result =
          jsonDecode(jsonEncode(response['result']))['homePartnerDTO'];
      if (result.length == 0) {
        isRequesting(false);
        isLoading(false);
        duoList2.refresh();
      } else {
        for (int i = 0; i < result.length; i++) {
          Map j = result[i];
          String nick = j['userNickname'];

          Duo a = Duo(
              name: nick,
              rank: j['tier'],
              position: [],
              image: j['profilePhotoUrl'],
              star: j['rating'],
              playStyle: '',
              introduce: '',
              price: j['price']);

          duoList2.add(a);
          // log(duoList2[i].name.toString());
        }
      }
    }
  }
}
