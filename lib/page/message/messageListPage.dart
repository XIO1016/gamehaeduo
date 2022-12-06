import 'dart:developer';

import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/page/message/messagePage.dart';
import 'package:cau_gameduo/controller/message/messageController.dart';
import '../../components/SizedBox.dart';
import '../../components/tierImage.dart';
import '../../model/duo.dart';
import '../app.dart';

class MessageListPage extends GetView<MessageController> {
  Duo duo = Get.arguments[0];
  int roomid = Get.arguments[1];
  int duoIdx = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
            onPressed: () {
              Get.offAll(App());
            },
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '쪽지',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 10, bottom: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Color(0xffEEE6E6)),
                  bottom: BorderSide(width: 1, color: Color(0xffEEE6E6)),
                ),
              ),
              child: Row(
                children: [
                  //프로필 사진
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: const Color(0xffD9D9D9),
                      child: Image.network(
                        duo.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Sbox(15, 0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        duo.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Sbox(0, 5),
                      (duo.rank == '')
                          ? const SizedBox()
                          : Row(
                              children: [
                                const Text(
                                  '티어',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Sbox(10, 0),
                                tierImage(duo.rank),
                                Sbox(5, 0),
                                Text(
                                  duo.rank,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                      Sbox(0, 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '주포지션',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Sbox(5, 0),
                          Row(
                            children: List.generate(
                              duo.position.length,
                              (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: maincolor, width: 1.0),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        duo.position[index],
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Sbox(5, 0)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(child: Sbox(10, 0)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      (duo.price == -1)
                          ? const SizedBox()
                          : Row(
                              children: [
                                Image.asset(
                                  "images/point.png",
                                  width: 20,
                                  height: 20,
                                ),
                                Sbox(5, 0),
                                Text(duo.price.toString()),
                              ],
                            ),
                      Sbox(0, 13),
                      if (controller.duoState.value == 0)
                        applyButton(
                          '신청 요청중', //신청 수락하기
                        )
                      else if (controller.duoState.value == 1)
                        applyButton(
                          '신청 수락하기',
                        )
                      else if (controller.duoState.value == 2)
                        applyButton(
                          '듀오 진행중',
                        )
                      else if (controller.isPlayer.value==true)
                        applyButton(
                          '듀오 신청하기',
                        )
                    ],
                  )
                ],
              ),
            ),
            //쪽지
            Column(
              children: List.generate(
                  controller.DuomessagList[duo.duoId]!.length,
                  (index) => _MessageComponent(index)),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            Get.to(() => MessagePage(), arguments: [duo, roomid]);
          },
          child: Container(
            width: Get.width,
            height: 60,
            color: maincolor,
            child: const Center(
              child: Text(
                '쪽지보내기',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget applyButton(String text) {
    return OutlinedButton(
      onPressed: () {
        if (controller.duoState.value == -1) {
          controller.applyDuo(roomid, duo);
        }
        if (controller.duoState.value == 1) {
          controller.acceptDuo(roomid, duoIdx);
        }
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.0, color: maincolor),
      ),
      child: Text(
        text, //듀요 신청중/듀오 진행중
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _MessageComponent(int i) {
    List messageList = controller.DuomessagList[duo.duoId]!;
    log(messageList[i].content);
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 0, bottom: 5),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: Color(0xffEEE6E6)),
      )),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              (messageList[i].isreceived)
                  ? const Text(
                      '받은 쪽지',
                      style: TextStyle(
                          color: Color(0xff0066FF),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      '보낸 쪽지',
                      style: TextStyle(
                          color: Color(0xffFFA800),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
              Expanded(child: Sbox(10, 0)),
              Text(
                //message.datetime,
                messageList[i].timestamp,
                style: const TextStyle(color: Color(0xffACA6A6), fontSize: 10),
              ),
            ],
          ),
        ),
        subtitle: Text(
          messageList[i].content,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
