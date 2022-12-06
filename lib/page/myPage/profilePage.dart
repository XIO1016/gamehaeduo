import 'package:cau_gameduo/controller/myPage/profileController.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../components/Color.dart';
import '../../components/SizedBox.dart';

class profilePage extends GetView<profileController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '내 프로필',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
          onPressed: () => Get.back(),
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          controller: controller.scrollController.value,
          child: Column(
            children: [
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: Get.width,
                  height: 380,
                  color: Colors.grey,
                  child: Image.network(
                    controller.myprofile.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 340,
                  child: Container(
                    width: Get.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
                        child: Container()),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '닉네임',
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          children: [
                            (controller.myprofile.isOn)
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.lightGreenAccent),
                                  )
                                : Container(),
                            Sbox(10, 0),
                            Text(
                              controller.myprofile.nick,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    Sbox(0, 10),
                    (controller.myprofile.isPlayer)
                        ? Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '티어',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      controller.myprofile.tier,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                              Sbox(0, 10)
                            ],
                          )
                        : Container(),
                    const Text(
                      '포지션',
                      style: TextStyle(fontSize: 15),
                    ),
                    Sbox(0, 10),
                    Row(
                      children: List<Widget>.generate(
                          controller.myprofile.position.length, (index) {
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
                                  controller.myprofile.position[index],
                                  style:
                                      TextStyle(color: maincolor, fontSize: 15),
                                ))),
                            Sbox(10, 0)
                          ],
                        );
                      }),
                    ),
                    Sbox(0, 20),
                    const Divider(thickness: 1, height: 10, color: Color(0xffE2E2E2)),
                    Sbox(0, 30),
                    if (controller.myprofile.isPlayer)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '플레이 스타일',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Sbox(0, 10),
                          Text(
                            controller.myprofile.playStyle,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          Sbox(0, 30),
                          const Text(
                            '자기소개',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Sbox(0, 10),
                          Text(
                            controller.myprofile.introduce,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          Sbox(0, 50),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                  child: const Divider(height: 20, thickness: 1),
                                ),
                              ),
                              const Text('리뷰'),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                  child: const Divider(height: 20, thickness: 1),
                                ),
                              ),
                            ],
                          ),
                          Sbox(0, 30),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  controller.myprofile.star.toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RatingBarIndicator(
                                  rating: controller.myprofile.star,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 40.0,
                                  direction: Axis.horizontal,
                                ),
                                Sbox(0, 40),
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.reviewList.length + 1,
                                    itemBuilder: (_, index) {
                                      if (index <
                                          controller.reviewList.length) {
                                        return SizedBox(
                                          height: 120,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child:Image.network(controller.reviewList[index].image),
                                                  ),
                                                  Sbox(10, 0),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .reviewList[index].nick,
                                                        style:
                                                        const TextStyle(fontSize: 13),
                                                      ),
                                                      Row(
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: controller
                                                                .reviewList[index]
                                                                .rating,
                                                            itemBuilder:
                                                                (context, index) =>
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: Colors.amber,
                                                                ),
                                                            itemCount: 5,
                                                            itemSize: 16.0,
                                                          ),
                                                          Sbox(10, 0),
                                                          Text(
                                                            controller
                                                                .reviewList[index]
                                                                .reviewTime,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: Color(
                                                                    0xff9E9E9E)),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Sbox(0, 10),
                                              RichText(
                                                  text: TextSpan(
                                                      text: controller
                                                          .reviewList[index]
                                                          .content,
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black))),
                                              Sbox(0, 30)
                                            ],
                                          ),
                                        );
                                      }
                                      if (controller.isRequesting.value ||
                                          controller.isLoading.value) {
                                        return const Center(
                                            child: RefreshProgressIndicator());
                                      }
                                      return Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Column(
                                            children: const [
                                              Text('리뷰 데이터의 마지막 입니다'),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      const Text(
                        '정보가 없습니다. 플레이어 되기를 통해 플레이어가 되세요!',
                        style: TextStyle(fontSize: 15),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
