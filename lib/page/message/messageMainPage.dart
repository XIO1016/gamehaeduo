import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/page/message/messagePage.dart';
import 'package:cau_gameduo/controller/message/messageController.dart';
import '../../components/SizedBox.dart';
import '../../model/duo.dart';

class MessageMainPage extends GetView<MessageController> {
  Duo duo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.initial();
    controller.getMessage(duo);
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
            onPressed: () => Get.back(),
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '쪽지',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
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
                      width: 40,
                      height: 40,
                      color: Color(0xffD9D9D9),
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
                      Row(
                        children: [
                          const Text(
                            '티어',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Sbox(10, 0),
                          Image.asset(
                            "images/point.png",
                            width: 20,
                            height: 20,
                          ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5, bottom: 2),
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
                      Row(
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
                      OutlinedButton(
                        onPressed: () {
                          controller.duoApplication();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: maincolor),
                        ),
                        child: (controller.duoState.value == 0)
                            ? const Text(
                                '듀오 신청하기', //듀요 신청중/듀오 진행중
                                style: TextStyle(color: Colors.black),
                              )
                            : const Text(
                                '듀오 신청 중', //듀요 신청중/듀오 진행중
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //쪽지
            Column(
              children: List.generate(controller.messageList.length,
                  (index) => _MessageComponent(index)),
            )
          ],
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessagePage()));
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
      ),
    );
  }

  Widget _MessageComponent(int i) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 0, bottom: 5),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: Color(0xffEEE6E6)),
      )),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              (controller.messageList[i].isreceived)
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
                controller.messageList[i].timestamp,
                style: TextStyle(color: const Color(0xffACA6A6), fontSize: 10),
              ),
            ],
          ),
        ),
        subtitle: Text(
          controller.messageList[i].content,
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
