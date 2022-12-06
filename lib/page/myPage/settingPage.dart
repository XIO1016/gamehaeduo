import 'package:cau_gameduo/components/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/controller/myPage/settingController.dart';
import '../../components/SizedBox.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: blackcolor),
          onPressed: () => Get.back(),
        ),
        titleSpacing: 0,
        elevation: 0,
        title: const Text(
          '설정',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => ListView(
            children: [
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0.0,
                  title: const Text('프로필 노출', style: TextStyle(fontSize: 16)),
                  trailing: Switch(
                      value: controller.on.value,
                      onChanged: (val) => controller.onOff()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    controller.on == true ? '켜짐' : '꺼짐',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Sbox(10, 0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
