import 'package:get/get.dart';

class RequestDuoController extends GetxController {

  RxInt temp=0.obs;

  RxInt whichTab=1.obs; //1은 요청한 듀오, 2는 요청 받은 듀오

  final requestingType = [
    '전체',
    '진행중',
    '과거'
  ].obs;
  RxString requestingSelected = "전체".obs;

  final requestedType = [
    '전체',
    '수락 대기',
    '진행중',
    '과거'
  ].obs;
  RxString requestedSelected = "전체".obs;


}