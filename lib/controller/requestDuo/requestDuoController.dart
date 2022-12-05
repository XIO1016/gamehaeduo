import 'dart:convert';
import 'dart:developer';

import 'package:cau_gameduo/controller/myPage/MyPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../components/messagePopUp.dart';
import '../../http/url.dart';
import '../../model/duo.dart';
import '../../model/request.dart';
import '../../page/login/kakao_loginV1.dart';

class RequestDuoController extends GetxController {
  static RequestDuoController get to => Get.find<RequestDuoController>();
  RxList requestedDuo = [].obs;
  RxList requested1Duo = [].obs;
  RxList requested2Duo = [].obs;
  RxList requested3Duo = [].obs;
  RxList requested4Duo = [].obs;

  RxList requestDuo = [].obs;
  RxList request1Duo = [].obs;
  RxList request2Duo = [].obs;
  RxList request3Duo = [].obs;

  RxInt requestedDuoNum = 0.obs;
  RxInt requestDuoNum = 0.obs;

  RxInt duoState = (-1).obs;
  RxInt whichTab = 1.obs; //1은 요청한 듀오, 2는 요청 받은 듀오

  final requestingType = ['전체', '진행중', '과거'].obs;
  RxString requestingSelected = "전체".obs;

  final requestedType = ['전체', '수락 대기', '진행중', '과거'].obs;
  RxString requestedSelected = "전체".obs;

  RxMap requestDuoStatus = {}.obs;
  RxMap requestedDuoStatus = {}.obs;

  getRequestDuoRefresh() async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    requestDuo([]);
    request1Duo([]);
    request2Duo([]);
    request3Duo([]);

    requestDuoNum(0);

    await getRequestDuo();
    Get.back();
  }

  getRequestedDuoRefresh() async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    requestedDuo([]);
    requested1Duo([]);
    requested2Duo([]);
    requested3Duo([]);
    requested4Duo([]);

    requestedDuoNum(0);

    await getRequestedDuo();
    Get.back();
  }

  getRequestedDuo() async {
    requestedDuo([]);
    var getRequestedDuo = await http.get(
        Uri.parse('${urlBase}api/duo/requested?userIdx=$userId'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getRequestedDuo.bodyBytes));
    log(response.toString());
    List result = response['result'];

    for (int i = 0; i < result.length; i++) {
      var r = result[i];
      DateTime date = DateTime.parse(r["requestTime"]);
      String requestTime = DateFormat('yy/MM/dd - HH:mm').format(date);
      Duo duo = Duo(
          image: r['image'],
          status: duoStatus(r['duoStatus'], false, r['reviewWritten']),
          introduce: '',
          rank: r['tier']??'',
          price: r['price'],
          playStyle: '',
          position: [],
          duoId: r['duoId'],
          name: r['nickname'],
          star: -1);
      Request request = Request(
        duo: duo,
        requestTime: requestTime,
      );
      requestedDuoStatus[duo.duoId] = duo.status;

      requestedDuo.add(request);
      requested1Duo.add(request);
      if (request.duo.status == 1) {
        requested2Duo.add(request);
      }
      if (request.duo.status == 2) {
        requested3Duo.add(request);
      } else {
        requested4Duo.add(request);
      }
    }
    requestedDuoNum(result.length);
  }

  getRequestDuo() async {
    requestDuo([]);
    var getRequestDuo = await http.get(
        Uri.parse('${urlBase}api/duo/request?userIdx=$userId'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "jwtAccessToken": jwtaccessToken
        });
    Map response = jsonDecode(utf8.decode(getRequestDuo.bodyBytes));
    log(response.toString());
    List result = response['result'];

    for (int i = 0; i < result.length; i++) {
      var r = result[i];
      DateTime date = DateTime.parse(r["requestTime"]);
      String requestTime = DateFormat('yy/MM/dd - HH:mm').format(date);

      Duo duo = Duo(
          image: r['image'],
          status: duoStatus(r['duoStatus'], true, r['reviewWritten']),
          introduce: '',
          rank: r['tier']??'',
          price: r['price'],
          playStyle: '',
          position: [],
          duoId: r['duoId'],
          name: r['nickname'],
          star: -1);
      Request request = Request(
        duo: duo,
        requestTime: requestTime,
      );
      requestDuoStatus[duo.duoId] = duo.status;
      requestDuo.add(request);
      request1Duo.add(request);
      if (request.duo.status == 0 || request.duo.status == 2) {
        request2Duo.add(request);
      } else {
        request3Duo.add(request);
      }
    }
    // log(request1Duo.toString());
    requestDuoNum(result.length);
  }

  cancelDuo(Duo duo) async {
    MyPageController.to.getRequestDuoNum();
    var cancelDuoRequest = await http.post(
      Uri.parse('${urlBase}api/duo/cancel'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "jwtAccessToken": jwtaccessToken
      },
      body: jsonEncode(
        <String, dynamic>{
          'userIdx': userId,
          'duoIdx': duo.duoId,
        },
      ),
    );
    Map cancelDuoResponse = jsonDecode(utf8.decode(cancelDuoRequest.bodyBytes));
    if (cancelDuoResponse['code'] == 1000) {
      Map result = cancelDuoResponse['result'];
      // log(result.toString());
      if (requestDuoStatus.containsKey(duo.duoId)){
        requestDuoStatus[duo.duoId]= 4;
      }
      else{
        requestedDuoStatus[duo.duoId]= 4;

      }
      duo.status = 4;
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: cancelDuoResponse['message'],
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
  }

  finishDuo(Duo duo) async {
    var finishDuoRequest = await http.post(
      Uri.parse('${urlBase}api/duo/finish'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "jwtAccessToken": jwtaccessToken
      },
      body: jsonEncode(
        <String, dynamic>{
          'userIdx': userId,
          'duoIdx': duo.duoId,
        },
      ),
    );

    Map finishDuoResponse = jsonDecode(utf8.decode(finishDuoRequest.bodyBytes));
    if (finishDuoResponse['code'] == 1000) {
      Map result = finishDuoResponse['result'];
      log(result.toString());
      if (requestDuoStatus.containsKey(duo.duoId)){
        requestDuoStatus[duo.duoId]= 3;
      }
      else{
        requestedDuoStatus[duo.duoId]= 3;

      }
      duo.status=3;
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: finishDuoResponse['message'],
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
  }
  acceptDuo(Duo duo) async{

    var acceptDuoRequest = await http.post(
      Uri.parse('${urlBase}api/duo/accept'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "jwtAccessToken": jwtaccessToken
      },
      body: jsonEncode(
        <String, dynamic>{
          'userIdx': userId,
          'duoIdx': duo.duoId,
        },
      ),
    );
    Map acceptDuoResponse = jsonDecode(utf8.decode(acceptDuoRequest.bodyBytes));
    if(acceptDuoResponse['code']==1000){
      Map result= acceptDuoResponse['result'];
      log(result.toString());
      if (requestDuoStatus.containsKey(duo.duoId)){
        requestDuoStatus[duo.duoId]= 1;
      }
      else{
        requestedDuoStatus[duo.duoId]= 1;

      }
      duo.status=1;

    }else{
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
            message: '듀오 신청받은 사람만 수락을 할 수 있습니다.',
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
  int duoStatus(String r, bool requestUser, bool reviewWritten) {

    if (r == 'WAITING') {
      log(r);
      if (requestUser == true) {
        //신청 요청중
        duoState(0);
        log(duoState.value.toString());

        return 0;
      }
      duoState(1);
      return 1; //수락하기
    } else if (r == 'PROCEEDING') {
      duoState(2);
      return 2; //듀오 진행중
    } else if (r == 'COMPLETE') {
      if (reviewWritten == true) {
        return 6;
      }
      //듀오 완료됨ee
      duoState(-1);
      return 3;
    } else if (r == 'CANCEL') {
      duoState(-1);
      return 4;
    } else {
      duoState(-1);
      return 5; //듀오 거절
    }
  }
}
