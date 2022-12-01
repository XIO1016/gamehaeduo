import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/page/message/messageListPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/message/messageController.dart';
import '../../model/duo.dart';

class MessagePage extends GetView<MessageController> {
  Duo duo = Get.arguments[0];
  dynamic roomid = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    controller.iswritten(false);
    controller.contentController.text='';
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,//dd
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
            onPressed: () =>Get.offAll(MessageListPage()),
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '쪽지',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Color(0xffEEE6E6)),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller.contentController,
                onChanged: (i) {
                  if (controller.contentController.text != '') {
                    controller.iswritten(true);
                  } else {
                    controller.iswritten(false);
                  }
                },
                maxLines: 10, //or null
                decoration:
                    const InputDecoration.collapsed(hintText: "내용을 입력하세요."),
              ),
            )),
        bottomSheet: GestureDetector(
          onTap: () {
            controller.sendMessage(duo,roomid);

          },
          child: (controller.iswritten.value)
              ? Container(
                  width: Get.width,
                  height: 60,
                  color: maincolor,
                  child: const Center(
                    child: Text(
                      '보내기',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              : Container(
                  width: Get.width,
                  height: 60,
                  color: const Color(0xffE9E9E9),
                  child: const Center(
                    child: Text(
                      '보내기',
                      style: TextStyle(color: Color(0xffB0B0B0), fontSize: 16),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
