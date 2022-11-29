import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/review/reviewController.dart';
import '../../components/SizedBox.dart';

class ReviewPage extends GetView<ReviewController> {
  const ReviewPage ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                      Icons.keyboard_arrow_left_rounded, color: blackcolor),
                  onPressed: () => Get.back(),
                ),
                titleSpacing: 0,
                elevation: 0,
                title: const Text(
                  '후기작성',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(70),
                      child: Container(
                        color: Colors.grey,
                      )
                      // child: Image.network(
                      //   //프로필 사진
                      //   controller.duoList2[index].image,
                      // ),
                    ),
                  ),
                  Sbox(0, 20),
                  RichText(
                    text: TextSpan(
                        children: const<TextSpan>[
                          TextSpan(text: '전주비빔밥',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )),
                          TextSpan(text: '님과의 듀오 후기를 남겨주세요!',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black                                      )),
                        ]),
                  ),
                  Sbox(0, 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      for(var i=0;i<5;i++)
                        Image.asset(
                          "images/star_grey.png",
                          width: 45,
                          height: 45,
                        ),
                    ],
                  ),
                  Sbox(0, 20),
                  SizedBox(
                    width: Get.width,
                    child: Container(
                      child: TextField(
                        maxLines: 10,
                        //controller: controller.,
                        // onChanged: (string) {
                        //   controller.isFinish();
                        // },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '후기를 남겨주세요'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: (controller.writeFinish.value)
                ? GestureDetector(
              onTap: () {
                //작성하기
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
                  '다음',
                  style: TextStyle(color: Color(0xffB0B0B0), fontSize: 16),
                ),
              ),
            ),

          ),
    );
  }

}
