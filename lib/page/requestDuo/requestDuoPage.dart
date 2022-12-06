import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/components/tierImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/requestDuo/requestDuoController.dart';
import '../../components/requestDuoPopUp.dart';
import '../../components/SizedBox.dart';
import '../../components/tierImage.dart';
import '../../model/request.dart';
import '../review/reviewPage.dart';
import 'dart:developer';

class RequestDuoPage extends GetView<RequestDuoController> {
  const RequestDuoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            elevation: 0.5,
            bottom: TabBar(
                labelColor: Colors.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.0, color: maincolor),
                  insets: const EdgeInsets.symmetric(horizontal: 50.0),
                ),
                onTap: (index) {},
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "요청한 듀오",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "요청 받은 듀오",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        body: TabBarView(
          children: [
            //요청한 듀오
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10.0,
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getRequestDuoRefresh();
                },
                child: Obx(
                  () => ListView(
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: SizedBox(
                                width: 85,
                                height: 40,
                                child: DropdownButton<RxString>(
                                    onChanged: (newValue) {
                                      controller.requestingSelected(
                                          newValue.toString());
                                      if (newValue == '전체') {
                                        controller
                                            .requestDuo(controller.request1Duo);
                                        controller.requestDuoNum(
                                            controller.request1Duo.length);
                                      } else if (newValue == '진행중') {
                                        controller
                                            .requestDuo(controller.request2Duo);

                                        controller.requestDuoNum(
                                            controller.request2Duo.length);
                                      } else if (newValue == '과거') {
                                        controller
                                            .requestDuo(controller.request3Duo);

                                        controller.requestDuoNum(
                                            controller.request3Duo.length);
                                      }
                                      log(controller.requestDuo.toString());
                                    },
                                    value: controller.requestingSelected,
                                    items: [
                                      for (var value
                                          in controller.requestingType)
                                        DropdownMenuItem(
                                          value: value.obs,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                    ]),
                              ),
                            ),
                          ),
                          (controller.requestDuoNum.value == 0)
                              ? const Center(
                                  child: Text('요청한 듀오가 없습니다'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                      children: List.generate(
                                          controller.requestDuoNum.value,
                                          (index) => requestBox(
                                              context,
                                              controller.requestDuo[index],
                                              1))),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //요청받은 듀오
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10.0,
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getRequestedDuoRefresh();
                  },
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: SizedBox(
                                width: 90,
                                child: DropdownButton<RxString>(
                                    onChanged: (newValue) {
                                      controller.requestedSelected(
                                          newValue.toString());
                                      if (newValue.toString() == '전체') {
                                        controller.requestedDuo(
                                            controller.requested1Duo);
                                        controller.requestedDuoNum(
                                            controller.requested1Duo.length);
                                      } else if (newValue.toString() ==
                                          '수락 대기') {
                                        log(newValue.toString());
                                        controller.requestedDuo(
                                            controller.requested2Duo);

                                        controller.requestedDuoNum(
                                            controller.requested2Duo.length);
                                      } else if (newValue.toString() == '진행중') {
                                        controller.requestedDuo(
                                            controller.requested3Duo);

                                        controller.requestedDuoNum(
                                            controller.requested3Duo.length);
                                      } else if (newValue.toString() == '과거') {
                                        controller.requestedDuo(
                                            controller.requested4Duo);

                                        controller.requestedDuoNum(
                                            controller.requested4Duo.length);
                                      }
                                    },
                                    value: controller.requestedSelected,
                                    items: [
                                      for (var value
                                          in controller.requestedType)
                                        DropdownMenuItem(
                                          value: value.obs,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                    ]),
                              ),
                            ),
                          ),
                          (controller.requestedDuoNum.value == 0)
                              ? const Center(
                                  child: Text('요청 받은 듀오가 없습니다'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                      children: List.generate(
                                          controller.requestedDuoNum.value,
                                          (index) => requestBox(
                                              context,
                                              controller.requestedDuo[index],
                                              2))),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestBox(BuildContext context, Request request, int i) {
    var status = {};
    if (i == 1) {
      status = controller.requestDuoStatus;
    } else {
      status = controller.requestedDuoStatus;
    }
    var duostatus = status[request.duo.duoId];
    return Container(
      width: Get.width - 20,
      height: (duostatus == 2 || duostatus == 1) ? 200 : 155,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          showStatus(duostatus),
          const Divider(
            thickness: 1,
            color: Color(0xffF0F0F0),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(
                    request.duo.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Sbox(10, 0),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(request.duo.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/point.png",
                              width: 18,
                              height: 18,
                            ),
                            Sbox(3, 0),
                            Text(
                              request.duo.price.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Sbox(0, 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text: '요청 시간: ',
                                style: TextStyle(
                                  color: Color(0xff727272),
                                  fontSize: 10,
                                )),
                            TextSpan(
                                text: request.requestTime,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.black)),
                          ]),
                        ),
                      ],
                    ),
                    Sbox(0, 8),
                    Row(
                      children: [
                        (request.duo.rank == '')
                            ? const SizedBox()
                            : Expanded(
                                child: Row(
                                  children: [
                                    tierImage(request.duo.rank),
                                    Sbox(3, 0),
                                    Text(
                                      request.duo.rank,
                                      style: const TextStyle(
                                        color: Color(0xff14BC57),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        (duostatus == 0)
                            ? OutlinedButton(
                                onPressed: () {
                                  CancelOngoingPopUp(context, request.duo.name,
                                      request.duo, request);
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  side: const BorderSide(
                                      color: Colors.black, width: 0.2),
                                ),
                                child: const Text(
                                  '취소',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (duostatus == 3 && i == 1)
                            ? OutlinedButton(
                                onPressed: () {
                                  log(request.duo.duoId.toString());
                                  log(request.duo.name.toString());
                                  Get.to(() => ReviewPage(),
                                      arguments: request.duo);
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  side: const BorderSide(
                                      color: Colors.black, width: 0.2),
                                ),
                                child: const Text(
                                  '리뷰 작성',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          (duostatus == 2) ? buttons('취소', '완료', request) : Container(),
          (duostatus == 1) ? buttons('거절', '수락', request) : Container()
        ],
      ),
    );
  }

  Widget showStatus(int i) {
    if (i == 0 || i == 1) {
      return const Text('신청 수락 대기중',
          style: TextStyle(
            color: Color(0xff14BC57),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ));
    } else if (i == 2) {
      return Text('진행중',
          style: TextStyle(
            color: maincolor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ));
    } else if (i == 3) {
      return const Text('듀오 완료',
          style: TextStyle(
            color: Color(0xff5a5a5a),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ));
    } else if (i == 4) {
      return const Text('취소',
          style: TextStyle(
            color: Color(0xff5a5a5a),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ));
    }
    return const Text('듀오 완료',
        style: TextStyle(
          color: Color(0xff5a5a5a),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ));
  }

  Widget buttons(String text1, String text2, Request request) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
          color: Color(0xffF0F0F0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                if (text1 == '거절') {
                  RejectRequestPopUp(
                      Get.context!, request.duo.name, request.duo, request);
                } else {
                  CancelOngoingPopUp(
                      Get.context!, request.duo.name, request.duo, request);
                }
              },
              style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  side: const BorderSide(color: Colors.black, width: 0.2),
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 25, right: 25)),
              child: Text(
                text1,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (text1 == '거절') {
                  AcceptRequestPopUp(
                      Get.context!, request.duo.name, request.duo, request);
                } else {
                  FinishOngoingPopUp(
                      Get.context!, request.duo.name, request.duo, request);
                }
              },
              style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: maincolor,
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 25, right: 25)),
              child: Text(
                text2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
