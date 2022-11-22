import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';

import '../../model/duo.dart';
import '../../model/message.dart';

class MessageController extends GetxController {
  TextEditingController contentController = TextEditingController();
  RxBool iswritten = false.obs;
  RxInt duoState = 0.obs;
  List<Message> messageList = [];
  void initial() {
    duoState(0);
    messageList = [];
  }

  void duoApplication() {
    duoState(1);
  }

  getMessage(Duo duo) {
    Message m =
        Message(content: '지금 가능?', isreceived: true, timestamp: '11/03 10:20');
    Message m1 =
        Message(content: 'ㅇㅇ 가능', isreceived: false, timestamp: '11/03 10:20');
    messageList.add(m);
    messageList.add(m1);
  }
}
