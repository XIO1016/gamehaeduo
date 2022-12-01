import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/model/messageRoom.dart';
import 'package:cau_gameduo/page/message/messageListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/page/message/messagePage.dart';
import 'package:cau_gameduo/controller/message/messageController.dart';
import '../../components/SizedBox.dart';
import '../../model/duo.dart';

class MessageMainPage extends GetView<MessageController> {

  @override
  Widget build(BuildContext context) {
    // controller.getAllRooms();
    return Obx(
      () => Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
         automaticallyImplyLeading: false,
          shape: const Border(
            bottom: BorderSide(color: Color(0xffEEE6E6), width: 1),
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '쪽지',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: (controller.messageRoomNum.value == 0)
            ? const Center(
                child: Text('쪽지 방이 없습니다.'),
              )
            : Column(
                children: [
                  Column(
                    children: List.generate(
                      controller.messageRoomNum.value,
                      (index) =>
                          MessageListProfile(controller.messageRoomList.values.toList()[index]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget MessageListProfile(MessageRoom room) {
    return GestureDetector(
      onTap: () {

        controller.getAllMessages(room.roomId,room.duo);

        //messageListPage로 이동
      },
      child: Container(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
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
                color: Color(0xffD9D9D9),
                child: Image.network(
                  room.duo.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Sbox(15, 0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room.duo.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        room.currentMessageTime,
                        style: TextStyle(
                            color: const Color(0xffACA6A6), fontSize: 10),
                      ),
                    ],
                  ),
                  Sbox(0, 8),
                  Text(
                    room.currentMessage,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
