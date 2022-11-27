import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../components/messagePopUp.dart';
import '../../http/url.dart';
import 'dart:convert';
import 'dart:developer';
import '../../model/duo.dart';
import '../../model/message.dart';
import '../../model/messageRoom.dart';
import '../../page/message/messageListPage.dart';

class MessageController extends GetxController {
  static MessageController get to => Get.find<MessageController>();
  TextEditingController contentController = TextEditingController();
  RxBool iswritten = false.obs;
  RxInt duoState = (-1).obs;
  List<Message> messageList = [];

  RxInt messageRoomNum = 0.obs;
  Map<int, MessageRoom> messageRoomList = {};

  Map<int, List> DuomessagList = {};

  void initial(Duo duo) {
    duoState(duo.status);
    messageList = [];
  }



  getAllRooms() async {
    messageRoomList={};
    var getAllRoomsRe = await http.get(
        Uri.parse('${urlBase}api/room?userIdx=$userId'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getAllRoomsRe.bodyBytes));
    List result = response['result'];
    messageRoomNum(result.length);
    // log('messageRoomList');

    for (int i = 0; i < result.length; i++) {
      var r = result[i];
      DateTime date = DateTime.parse(r["currentMessageTime"]);
      String sendDate = DateFormat('yy/MM/dd - HH:mm').format(date);

      MessageRoom room = MessageRoom(
          duo: Duo(image: r['profileImageUrl'],
              status: -1,
              introduce: '',
              rank: '',
              price: -1,
              playStyle: '',
              position: [],
              duoId: r['duoId'],
              name: r['duoName'],
              star: -1),
          roomId: r['roomId'],

          currentMessage: r['currentMessage'],
          currentMessageTime: sendDate);
      messageRoomList[room.roomId]=room;

    }
  }

  sendMessage(Duo duo) async {
    var sendMessage = await http.post(
      Uri.parse('${urlBase}api/note/send'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "jwtAccessToken": jwtaccessToken
      },
      body: jsonEncode(
        <String, dynamic>{
          'noteRoomIdx': 0,
          'noteMessage': contentController.text,
          'senderIdx': userId,
          'receiverIdx': duo.duoId,
        },
      ),
    );

    Map response = jsonDecode(utf8.decode(sendMessage.bodyBytes));
    Map result = response['result'];
    // log(result.toString());
    await getAllRooms();
  }

  getAllMessages(int roomid, Duo duo) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    var getAllMessage = await http.get(
        Uri.parse(
            '${urlBase}api/note/room?roomId=${roomid}&userIdx=$userId&duoIdx=${duo
            .duoId}'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getAllMessage.bodyBytes));

    Map result = response['result'];
    Map duoProfileRe = result['duoProfile'];
    List message = result['message'];
    List messages = [];

    duo = Duo(duoId: duo.duoId,
        status: -1,
        name: duo.name,
        rank: duoProfileRe['tier'],
        position: [],
        image: duo.image,
        playStyle: '',
        introduce: '',
        star: -1,
        price: duoProfileRe['price']);


    if (duoProfileRe['top'] == 1)
      duo.position.add('탑');
    if (duoProfileRe['jungle'] == 1)
      duo.position.add('정글');
    if (duoProfileRe['mid'] == 1)
      duo.position.add('미드');
    if (duoProfileRe['ad'] == 1)
      duo.position.add('원딜');
    if (duoProfileRe['supporter'] == 1)
     duo.position.add('서포터');


    for (int i = 0; i < message.length; i++) {
      var r = message[i];
      DateTime date = DateTime.parse(r["sendAt"]);
      String sendDate = DateFormat('yy/MM/dd - HH:mm').format(date);
      bool isreceived = true;
      if (r['senderId'].toString() == userId) {
        isreceived = false;
      }
      Message m = Message(
          messageid: r['messageId'],
          content: r['noteMessage'],
          isreceived: isreceived,
          timestamp: sendDate);
      messages.add(m);
    }
    DuomessagList[duo.duoId] = messages;

    Get.back();
    Get.to(() => MessageListPage(),arguments: [duo,roomid]);
  }

  applyDuo(int roomid,Duo duo) async{

    log(duo.status.toString());
    var applyDuoRequest = await http.post(
      Uri.parse('${urlBase}api/duo'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "jwtAccessToken": jwtaccessToken
      },
      body: jsonEncode(
        <String, dynamic>{
          'userIdx': userId,
          'playerIdx': duo.duoId,
        },
      ),
    );
    Map applyDuoResponse = jsonDecode(utf8.decode(applyDuoRequest.bodyBytes));
    if(applyDuoResponse['code']==1000){
      Map result= applyDuoResponse['result'];
      log(result.toString());
      messageRoomList[roomid]!.duo.status=0;
      duoState(0);

    }else{
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
            message: '포인트가 부족해 신청할 수 없습니다.',
            okCallback: () {
              Get.back();
              Get.back();
            },
            okmessage: '확인',
            cancelCallback:() {
              Get.back();
            },
          ));
    }
  }
}
