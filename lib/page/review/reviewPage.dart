import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/review/reviewController.dart';
import '../../components/SizedBox.dart';
import '../../model/duo.dart';

class ReviewPage extends GetView<ReviewController> {
  Duo duo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.writeFinish(false);
    controller.rating(0.0);
    controller.reviewController.text = '';
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
            onPressed: () => Get.back(),
          ),
          titleSpacing: 0,
          elevation: 0,
          title: const Text(
            '후기작성',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(70),
                      child: Image.network(
                        //프로필 사진
                        duo.image,
                      ),
                    ),
                  ),
                  Sbox(0, 20),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: duo.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                      TextSpan(
                          text: '님과의 듀오 후기를 남겨주세요!',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ]),
                  ),
                  Sbox(0, 20),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.rating(rating);
                      controller.isFinish();
                    },
                  ),
                  Sbox(0, 20),
                  SizedBox(
                    width: Get.width,
                    child: TextField(
                      maxLines: 10,
                      controller: controller.reviewController,
                      onChanged: (string) {
                        controller.isFinish();
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: '후기를 남겨주세요'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: (controller.writeFinish.value)
            ? GestureDetector(
                onTap: () {
                  controller.writeReview(duo);
                },
                child: Container(
                  width: Get.width,
                  height: 60,
                  color: maincolor,
                  child: const Center(
                    child: Text(
                      '작성하기',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            : Container(
                width: Get.width,
                height: 60,
                color: Color(0xffE9E9E9),
                child: const Center(
                  child: Text(
                    '작성하기',
                    style: TextStyle(color: Color(0xffB0B0B0), fontSize: 16),
                  ),
                ),
              ),
      ),
    );
  }
}
