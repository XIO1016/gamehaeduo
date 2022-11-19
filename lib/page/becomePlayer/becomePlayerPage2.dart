import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/becomePlayer/BecomePlayerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/SizedBox.dart';


class BecomePlayerPage2 extends GetView<BecomePlayerController> {
  const BecomePlayerPage2 ({Key? key}) : super(key: key);

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
              title: const Text('플레이어 되기(2/2)',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
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
                      onChanged: (newValue){
                        controller.selected(newValue.toString());},
                      value: controller.selected,
                      items: [
                        for(var value in controller.tierList)
                          DropdownMenuItem(
                            child: Text(value),
                            value: value.obs,
                          ),
                      ]
                  ),
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

              //---포지션
                  Sbox(0, 30),
                  const Text(
                    '포지션',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Sbox(0,10),
                  Row(
                    children: [
                      positionChoiceBox(0),Sbox(10, 0),
                      positionChoiceBox(1),Sbox(10, 0),
                      positionChoiceBox(2),Sbox(10, 0),
                      positionChoiceBox(3),Sbox(10, 0),
                      positionChoiceBox(4),
                    ],
                  ),
                  Sbox(0,30),

              //---닉네임
                const Text(
                  '닉네임',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                  Sbox(0, 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField( // 할 일: 회원가입에서 저장한 닉네임 불러오기
                          cursorColor: maincolor,
                          controller: controller.nickController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: maincolor)),
                            suffixIcon: (controller.checkNickDup.value)
                                ? Icon(
                              Icons.check,
                              color: maincolor,
                            )
                                : null,
                            hintText: "영어, 한글, 숫자 조합 2-10자리",
                            hintStyle: const TextStyle(
                                fontSize: 15, color: Color(0xff727272)),
                          ),
                        ),
                      ),
                      Sbox(10, 0),
                      GestureDetector(
                        onTap: () {
                          controller.checkDuplicated();
                          },
                        child: Container(
                          width: 80,
                          height: 43,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5,
                                  color: (controller.checkNickDup.value)
                                      ? maincolor
                                      : const Color(0xffAFAFAF))),
                          child: const Center(child: Text('중복확인')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomSheet: GestureDetector(
              onTap: () {},
              child: Container(
                width: Get.width,
                height: 60,
                color: const Color(0xffE9E9E9),
                child: const Center(
                  child: Text('제출',
                    style: TextStyle(
                        color: Color(0xffB0B0B0),
                        fontSize: 16),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  //성별 선택 상자
  Widget genderChoiceBox(int i) {
    return GestureDetector(
      onTap: () => controller.checkGender(i),
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
                    : Color(0xffB4B4B4),
              ),
            )),
      ),
    );
  }

  //포지션 선택 상자
  Widget positionChoiceBox(int i) {
    return GestureDetector(
      onTap: () => controller.checkPosition(i),
      child: Container(
        width: Get.width / 5 - 30,
        height: 50,
        decoration: (controller.isSelectedPosition[i] == true)
            ? BoxDecoration(
            color: Colors.white, border: Border.all(color: maincolor))
            : const BoxDecoration(color: Color(0xffF4F4F4)),
        child: Center(
            child: Text(
              controller.position[i],
              style: TextStyle(
                fontSize: 16,
                color: (controller.isSelectedPosition[i] == true)
                    ? maincolor
                    : const Color(0xffB4B4B4),
              ),
            )),
      ),
    );
  }

}
