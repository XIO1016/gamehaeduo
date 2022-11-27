import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';

import '../../model/duo.dart';
import '../../model/message.dart';
import '../../model/messageRoom.dart';

class MessageController extends GetxController {
  static MessageController get to => Get.find<MessageController>();
  TextEditingController contentController = TextEditingController();
  RxBool iswritten = false.obs;
  RxInt duoState = 0.obs;
  List<Message> messageList = [];

  RxInt messageRoomNum = 0.obs;
  RxList messageRoomList = [].obs;

  void initial() {
    duoState(0);
    messageList = [];
  }

  duoApplication() {
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

  getAllRooms() async {
    var getAllRoomsRe = await http.get(
        Uri.parse('${urlBase}api/room?userIdx=$userId'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getAllRoomsRe.bodyBytes));
    List result=response['result'];
    messageRoomNum(result.length);

    for (int i = 0; i < result.length; i++) {
      var r = result[i];

      MessageRoom room = MessageRoom(
          roomId: r['roomId'],
          duoId: r['duoId'],
          duoName: r['duoName'],
          image: r['profileImageUrl'],
          currentMessage: r['currentMessage'],
          currentMessageTime: r['currentMessageTime']);
      messageRoomList.add(room);
    }
  }

  sendMessage(Duo duo) async {
    var sendMessage = await http.post(Uri.parse('${urlBase}api/note/send'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        },
        body: jsonEncode(<String, dynamic>{
          'noteRoomIdx':0,
          'noteMessage': contentController.text,
          'senderIdx': userId,
          'receiverIdx': duo.duoId,
        }));


    Map response = jsonDecode(utf8.decode(sendMessage.bodyBytes));
    Map result=response['result'];
    log(result.toString());
    getAllRooms();

  }
}
