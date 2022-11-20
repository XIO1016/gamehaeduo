import 'dart:developer';

import 'package:cau_gameduo/controller/searchDuo/seachDuoController.dart';
import 'package:cau_gameduo/page/duoProfile/duoProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import '../../components/Color.dart';
import '../../components/SizedBox.dart';
import '../../model/duo.dart';

class searchDuoPage extends GetView<searchDuoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: Get.width,
            height: 60,
            decoration: BoxDecoration(
                color: maincolor, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                Sbox(10, 0),
                const Center(
                  child: Text(
                    '쪽지 보내기',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            '듀오 목록',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        titleSpacing: 0,
      ),
      body: Obx(
        () => Column(
          children: [
            if (controller.duoNum.value == 0)
              const Text('듀오가 없어요')
            else
              Container(
                color: Colors.white,
                width: 700,
                height: 600,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return Swiper(
                      loop: true,
                      controller: controller.cardController,
                      itemCount: controller.duoNum.value,
                      itemBuilder: (BuildContext context, int index) {
                        return CardView(duo: controller.duoList[index]);
                      },
                      viewportFraction: 0.8,
                      scale: 0.9,
                      layout: SwiperLayout.TINDER,
                      itemWidth: 500,
                      itemHeight: 550,
                      index: 1,
                      onIndexChanged: (index) {
                        log(index.toString());
                        if (index % 9 == 0) {
                          log('update');

                          controller.updateDuo();
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    required this.duo,
  }) : super(key: key);
  final Duo duo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => duoProfilePage(), arguments: duo);

        log(duo.name.toString());
      },
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(height: 380, child: Image.network(duo.image)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(duo.name,
                        style: TextStyle(
                            color: blackcolor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                  ),
                  Sbox(0, 14),
                  Row(
                    children: [
                      Text("티어      ",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: blackcolor)),
                      Text(duo.rank,
                          style: TextStyle(
                              color: blackcolor, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Sbox(0, 10),
                  Row(
                    children: [
                      Text("포지션   ",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: blackcolor)),
                      Row(
                        children: List<Widget>.generate(
                          duo.position.length,
                          (index) {
                            return Row(
                              children: [
                                Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: maincolor,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                        child: Text(
                                      duo.position[index],
                                      style: TextStyle(
                                          color: maincolor, fontSize: 15),
                                    ))),
                                Sbox(10, 0)
                              ],
                            );
                          },
                        ),
                      ),
                    ],
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
