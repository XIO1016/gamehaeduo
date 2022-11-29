import 'package:cau_gameduo/page/app.dart';
import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';

import '../login/SignUpController.dart';

class ReviewController extends GetxController {
  //포인트
  TextEditingController reviewController = TextEditingController();
  RxBool writeFinish = false.obs;


  void isFinish() {
    writeFinish(
        reviewController.text != '' //후기 작성
        //??별점
    );
  }


}
