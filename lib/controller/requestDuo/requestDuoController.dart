import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../http/url.dart';
import '../../model/duo.dart';
import '../../model/request.dart';
import '../../page/login/kakao_loginV1.dart';

class RequestDuoController extends GetxController {
  static RequestDuoController get to => Get.find<RequestDuoController>();
  Map<int, Request> requestedDuo = {};
  Map<int, Request> requestDuo = {};
  RxInt temp = 0.obs;

  RxInt whichTab = 1.obs; //1은 요청한 듀오, 2는 요청 받은 듀오

  final requestingType = ['전체', '진행중', '과거'].obs;
  RxString requestingSelected = "전체".obs;

  final requestedType = ['전체', '수락 대기', '진행중', '과거'].obs;
  RxString requestedSelected = "전체".obs;

  getRequestedDuo() async {
    requestedDuo = {};
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
      DateTime date = DateTime.parse(r["currentMessageTime"]);
      String requestTime = DateFormat('yy/MM/dd - HH:mm').format(date);

      Request request = Request(
        duo: Duo(
            image: r['profileImageUrl'],
            status: duoStatus(r['duoStatus']),
            introduce: '',
            rank: r['tier'],
            price: r['price'],
            playStyle: '',
            position: [],
            duoId: r['duoId'],
            name: r['nickname'],
            star: -1),
        requestTime: requestTime,
      );
      requestedDuo[i] = request;
      log(request.duo.name);
    }

  }

  getRequestDuo() async {
    requestDuo = {};
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
      DateTime date = DateTime.parse(r["currentMessageTime"]);
      String requestTime = DateFormat('yy/MM/dd - HH:mm').format(date);

      Request request = Request(
        duo: Duo(
            image: r['profileImageUrl'],
            status: duoStatus(r['duoStatus']),
            introduce: '',
            rank: r['tier'],
            price: r['price'],
            playStyle: '',
            position: [],
            duoId: r['duoId'],
            name: r['nickname'],
            star: -1),
        requestTime: requestTime,
      );
      requestDuo[i] = request;
      log(request.duo.name);
    }
  }
  int duoStatus(String r){
    if (r=='WAITING'){
      return 0;
    }
    else if(r=='P'){
      return 1;
    }else if(r=='신청 수락됨'){//듀오중ddd
      return 2;
    }else if(r=='듀오 취소'){
      return 3;
    }
    else{
      return 4;//듀오 완료
    }

  }
}
