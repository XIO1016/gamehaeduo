import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePopup extends StatelessWidget {
  final String? message;
  final String? okmessage;
  final Function()? okCallback;
  final Function()? cancelCallback;

  MessagePopup({
    Key? key,
    required this.message,
    required this.okmessage,
    required this.okCallback,
    this.cancelCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Container(
              color: Colors.white,
              width: Get.width * 0.9,
              height: 180,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width * 0.9,
                    height: 130,
                    child: Center(
                      child: Text(
                        message!,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff7D7D7D)),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xffD9D9D9),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: cancelCallback,
                        child: Container(
                          height: 40,
                          width: Get.width * 0.44,
                          child: Center(
                            child: Text(
                              '취소',
                              style: TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 48,
                        color: Color(0xffD9D9D9),
                      ),
                      GestureDetector(
                          onTap: okCallback,
                          child: Container(
                            height: 40,
                            width: Get.width * 0.44,
                            child: Center(
                              child: Text(
                                okmessage!,
                                style: TextStyle(
                                    color: Color(0xff545DAD),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
