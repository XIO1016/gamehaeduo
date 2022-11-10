import 'package:cau_gameduo/controller/home/homePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class homePage extends GetView<homePageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('게임해듀오'),
          ),
          body: Text(controller.duoNum.toString()),
        ));
  }
}
