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
  RxMap requestedDuo = {}.obs;
  RxMap requested1Duo = {}.obs;
  RxMap requested2Duo = {}.obs;
  RxMap requested3Duo = {}.obs;
  RxMap requested4Duo = {}.obs;



  RxMap requestDuo = {}.obs;
  RxMap request1Duo = {}.obs;
  RxMap request2Duo = {}.obs;
  RxMap request3Duo = {}.obs;

  RxInt requestedDuoNum = 0.obs;
  RxInt requestDuoNum = 0.obs;
  RxInt temp = 0.obs;
  RxInt duoState = (-1).obs;
  RxInt whichTab = 1.obs; //1은 요청한 듀오, 2는 요청 받은 듀오

  final requestingType = ['전체', '진행중', '과거'].obs;
  RxString requestingSelected = "전체".obs;

  final requestedType = ['전체', '수락 대기', '진행중', '과거'].obs;
  RxString requestedSelected = "전체".obs;

  getRequestedDuo() async {
    requestedDuo({});
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

      Request request = Request(
        duo: Duo(
            image: r['image'],
            status: duoStatus(r['duoStatus'], false),
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
      if(request.duo.status==1){
        requested2Duo[i]= request;
      }if(request.duo.status==2){
        requested3Duo[i]= request;
      }
      else{
        requested4Duo[i]=request;
      }

    }
    requested1Duo(requestedDuo);
    requestedDuoNum(result.length);
  }

  getRequestDuo() async {
    requestDuo({});
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

      Request request = Request(
        duo: Duo(
            image: r['image'],
            status: duoStatus(r['duoStatus'], true),
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
      if(request.duo.status==0|| request.duo.status==2){
        request2Duo[i]= request;
      }
      else{
        request3Duo[i]=request;
      }
    }
    request1Duo(requestDuo);
    log(request1Duo.toString());
    requestDuoNum(result.length);
  }

  int duoStatus(String r, bool requestUser) {
    log(r);
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
