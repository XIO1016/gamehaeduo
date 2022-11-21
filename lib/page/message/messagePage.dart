import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/page/message/messageMainPage.dart';
import 'package:cau_gameduo/controller/message/messageController.dart';
import '../../components/SizedBox.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Color(0xffEEE6E6)),
                ),
              color: Colors.white,),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                maxLines: controller.imsi==''?8:10, //or null
                decoration: InputDecoration.collapsed(hintText: "내용을 입력하세요."),
              ),
            )
        ),
            bottomSheet: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageMainPage()));
              },
              child: Container(
                width: Get.width,
                height: 60,
                color: maincolor,
                child: const Center(
                  child: Text(
                    '보내기',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
      ),
    );
  }

}
