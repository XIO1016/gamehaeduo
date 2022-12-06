import 'package:cau_gameduo/controller/requestDuo/requestDuoController.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../components/messagePopUp.dart';
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';
import '../../model/duo.dart';


class ReviewController extends GetxController {


  //포인트
  TextEditingController reviewController = TextEditingController();
  RxBool writeFinish = false.obs;
  RxDouble rating = 0.0.obs;

  void isFinish() {
    writeFinish(reviewController.text != '' //후기 작성
        &&
        rating.value != 0.0);
  }

  writeReview(Duo duo) async {
    log(duo.name);
    var writeReviewRe = await http.post(Uri.parse('${urlBase}api/review'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        },
        body: jsonEncode(<String, dynamic>{
          'duoIdx': duo.duoId,
          'userIdx': int.parse(userId),
        'reviewText':reviewController.text,
          'reviewRating':rating.value
        }));

    Map writeReviewResponse = jsonDecode(utf8.decode(writeReviewRe.bodyBytes));
    log(writeReviewResponse.toString());
    if (writeReviewResponse['code'] == 1000) {
      // Map result = writeReviewResponse['result'];
      // log(result.toString());
      RequestDuoController.to.getRequestDuoRefresh();
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: writeReviewResponse['message'],
                okCallback: () {
                  Get.back();
                  Get.back();
                },
                okmessage: '확인',
                cancelCallback: () {
                  Get.back();
                },
              ));
    }
    Get.back();
  }
}
