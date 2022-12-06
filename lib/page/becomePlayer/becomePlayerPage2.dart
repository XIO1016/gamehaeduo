import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/becomePlayer/BecomePlayerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/SizedBox.dart';

class BecomePlayerPage2 extends GetView<BecomePlayerController> {
  const BecomePlayerPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            '플레이어 되기(2/2)',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //티어
              const Text(
                '티어',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Sbox(0, 10),
              DropdownButton<RxString>(
                  dropdownColor: Colors.white,
                  onChanged: (newValue) {
                    controller.selected(newValue.toString());
                    controller.isFinish2();
                  },
                  value: controller.selected,
                  items: [
                    for (var value in controller.tierList)
                      DropdownMenuItem(
                        value: value.obs,
                        child: Text(value),
                      ),
                  ]),
              Sbox(0, 30),

              //성별
              const Text(
                '성별',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Sbox(0, 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  genderChoiceBox(0), //남자
                  genderChoiceBox(1), //여자
                ],
              ),

            ],
          ),
        ),
        bottomSheet: (controller.writeFinish2.value)
            ? GestureDetector(
                onTap: () {
                  controller.postPlayer();
                },
                child: Container(
                  width: Get.width,
                  height: 60,
                  color: maincolor,
                  child: const Center(
                    child: Text(
                      '제출',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            : Container(
                width: Get.width,
                height: 60,
                color: const Color(0xffE9E9E9),
                child: const Center(
                  child: Text(
                    '제출',
                    style: TextStyle(color: Color(0xffB0B0B0), fontSize: 16),
                  ),
                ),
              ),
      ),
    );
  }

  //성별 선택 상자
  Widget genderChoiceBox(int i) {
    return GestureDetector(
      onTap: () {
        controller.checkGender(i);
        controller.isFinish2();
      },
      child: Container(
        width: Get.width / 2 - 30,
        height: 50,
        decoration: (controller.isSelectedGender[i] == true)
            ? BoxDecoration(
                color: Colors.white, border: Border.all(color: maincolor))
            : const BoxDecoration(color: Color(0xffF4F4F4)),
        child: Center(
            child: Text(
          controller.gender[i],
          style: TextStyle(
            fontSize: 16,
            color: (controller.isSelectedGender[i] == true)
                ? maincolor
                : const Color(0xffB4B4B4),
          ),
        )),
      ),
    );
  }

}
