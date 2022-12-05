import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../http/url.dart';
import '../../model/review.dart';
import '../../page/login/kakao_loginV1.dart';

class duoProfilePageController extends GetxController {RxList reviewList = [].obs;
RxInt page = 0.obs;
var isLoading = false.obs; //로딩중
var isRequesting = true.obs; //다음 데이터 유무
Rx<ScrollController> scrollController = ScrollController().obs;
RxInt duoid= 0.obs;
@override
void onInit() {
  scrollController.value.addListener(() {
    // print('offset = ${scrollController.value.position}');
    if ((scrollController.value.position.pixels ==
        scrollController.value.position.maxScrollExtent) &&
        isRequesting.value) {
      getData();
    }
  });
  super.onInit();
}
initial(int duoId) async{
  page(0);
  isRequesting(true);
  reviewList([]);
  duoid(duoId);
  getData();
}
getData() async {
  isLoading.value = true;

  await getReviews();
  page.value += 1;
  isRequesting(false);
  // log()
  }

reload() async {
  isLoading.value = true;

  getData();
}


getReviews() async{
  var getReviewsRe = await http.get(
      Uri.parse('${urlBase}api/review?userIdx=${duoid.value}&page=${page.value}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "jwtAccessToken": jwtaccessToken
      });
  Map response = jsonDecode(utf8.decode(getReviewsRe.bodyBytes));
  log(response.toString());
  if (response['isSuccess']) {
    List result =
    jsonDecode(jsonEncode(response['result']))['reviews'];
    if (result.length == 0) {
      isRequesting(false);
      isLoading(false);
      reviewList.refresh();
    } else {
      for (int i = 0; i < result.length; i++) {
        Map j = result[i];
        String nick = j['nickname'];
        DateTime date = DateTime.parse(j["reviewTime"]);
        String reviewTime = DateFormat('yy/MM/dd - HH:mm').format(date);

        Review a = Review(
            nick: nick,
            reviewerId: j['reviewerId'],
            image: j['image'],
            rating: j['rating'],
            content: j['reviewContent'],
            reviewTime: reviewTime
        );

        reviewList.add(a);
        // log(duoList2[i].name.toString());
      }
    }
  }
}}
