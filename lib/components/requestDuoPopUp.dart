import 'package:cau_gameduo/controller/requestDuo/requestDuoController.dart';
import 'package:cau_gameduo/model/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/duo.dart';

void CancelRequestPopUp(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            height: height / 8,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '전주비빔밥',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff5D5D5D))),
                      TextSpan(
                          text: '님에게 신청한 듀오를',
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff9D9D9D))),
                    ]),
                  ),
                  const Text('취소 하시겠습니까?',
                      style: TextStyle(fontSize: 15, color: Color(0xff9D9D9D))),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('돌아가기',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7D7D7D))),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            '신청취소',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff545DAD)),
          ),
        ),
      ],
    ),
  );
}

void CancelOngoingPopUp(BuildContext context, String name, Duo duo,Request request) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            height: height / 8,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff5D5D5D))),
                      const TextSpan(
                          text: '님과 진행중인 듀오를',
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff9D9D9D))),
                    ]),
                  ),
                  const Text('취소 하시겠습니까?',
                      style: TextStyle(fontSize: 15, color: Color(0xff9D9D9D))),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('돌아가기',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7D7D7D))),
        ),
        TextButton(
          onPressed: () {
            RequestDuoController.to.cancelDuo(duo,request);
            Get.back();
          },
          child: const Text(
            '듀오 취소',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff545DAD)),
          ),
        ),
      ],
    ),
  );
}

void FinishOngoingPopUp(BuildContext context,String name, Duo duo,Request request) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            height: height / 8,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children:  <TextSpan>[
                      TextSpan(
                          text: name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff5D5D5D))),
                      const TextSpan(
                          text: '님과 진행중인 듀오를',
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff9D9D9D))),
                    ]),
                  ),
                  const Text('완료 하시겠습니까?',
                      style: TextStyle(fontSize: 15, color: Color(0xff9D9D9D))),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('취소',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7D7D7D))),
        ),
        TextButton(
          onPressed: () {
            RequestDuoController.to.finishDuo(duo,request);
            Navigator.pop(context, 'OK');
          },
          child: const Text(
            '완료',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff545DAD)),
          ),
        ),
      ],
    ),
  );
}

void AcceptRequestPopUp(BuildContext context,String name, Duo duo,Request request) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            height: height / 8,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children:  <TextSpan>[
                      TextSpan(
                          text: name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff5D5D5D))),
                      const TextSpan(
                          text: '님의 듀오 요청을',
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff9D9D9D))),
                    ]),
                  ),
                  const Text('수락 하시겠습니까?',
                      style: TextStyle(fontSize: 15, color: Color(0xff9D9D9D))),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('취소',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7D7D7D))),
        ),
        TextButton(
          onPressed: () {
            RequestDuoController.to.acceptDuo(duo,request);
            Navigator.pop(context, 'OK');},
          child: const Text(
            '수락',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff545DAD)),
          ),
        ),
      ],
    ),
  );
}

void RejectRequestPopUp(BuildContext context,String name, Duo duo,Request request) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            height: height / 8,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children:  <TextSpan>[
                      TextSpan(
                          text: name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff5D5D5D))),
                      const TextSpan(
                          text: '님의 듀오 요청을',
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff9D9D9D))),
                    ]),
                  ),
                  const Text('거절 하시겠습니까?',
                      style: TextStyle(fontSize: 15, color: Color(0xff9D9D9D))),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('취소',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7D7D7D))),
        ),
        TextButton(
          onPressed: () {
            RequestDuoController.to.finishDuo(duo,request);
            Navigator.pop(context, 'OK');},
          child: const Text(
            '거절',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff545DAD)),
          ),
        ),
      ],
    ),
  );
}
