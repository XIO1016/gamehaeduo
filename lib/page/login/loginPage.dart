import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cau_gameduo/page/login/kakao_loginV1.dart';

import '../../components/SizedBox.dart';


class LoginPage extends GetView<SignUpController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                titleSpacing: 20,
                elevation: 0,
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homePage()));
                  },

                )
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Center(
                  child: Column(
                    children: [

                          Image.asset(
                            "images/logo.png",
                            width: 100,
                            height: 100,
                          ),

                          Text('게임해듀오',
                              style: TextStyle(
                                color: maincolor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                  )
                ),
                Sbox(0, 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Sbox(0, 10),
                    Sbox(0, 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: maincolor,
                            controller: controller.nickController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,color: Colors.grey), //<-- SEE HERE
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: maincolor)),
                              prefixIcon: Icon(Icons.person_rounded,),
                              hintText: "아이디",
                              hintStyle: const TextStyle(
                                  fontSize: 15, color: Color(0xff727272)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Sbox(0, 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: maincolor,
                            controller: controller.nickController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,color: Colors.grey), //<-- SEE HERE
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: maincolor)),
                              prefixIcon: (controller.checkNickDup.value)
                                  ? Icon(
                                Icons.check,
                                color: maincolor,
                              )
                                  : Icon(Icons.https,),
                              hintText: "비밀번호",
                              hintStyle: const TextStyle(
                                  fontSize: 15, color: Color(0xff727272)),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Sbox(0,30),
                    Row(
                      children: [Expanded(
                        child:
                          ElevatedButton(
                              onPressed:(){},
                              child: Text('로그인',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),),
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size(0,60),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                backgroundColor: maincolor,
                                padding: EdgeInsets.only(bottom: 5, left: 25, right: 25)
                            ),
                          ),
                      ),
                        ],
                    ),
                    Sbox(0, 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('회원가입',
                            style:TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Sbox(0, 30),
                      Stack(
                        alignment: Alignment.center,
                        children:[
                          Divider(color: Color(0xffF4F4F4), thickness: 1.0),
                          Container(
                            width: 50,
                            height: 30,
                            color: Colors.white,
                          ),
                          Text('또는',
                          style: TextStyle(
                            color: Color(0xffC4C4C4))
                          ),
                        ]
                      ),
                    Sbox(0, 30),
                    Row(
                      children: [
                        Expanded(child:
                        GestureDetector(
                            child: Container(
                                width: 300,
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image:
                                    AssetImage("images/kakao_login_large_wide.png"),
                                    fit: BoxFit.cover,
                                  ), // button text
                                )),
                            onTap: () {
                              //kakaoLogin.login();
                            }),
                        ),
                      ],
                    ),
                  ],
                ),

              ]),
            ),
          ),
    );
  }

  Widget nonSelected(int i) {
    return GestureDetector(
      onTap: () => controller.checkposition(i),
      child: Container(
        width: Get.width / 2 - 30,
        height: 50,
        decoration: (controller.isSelected[i] == true)
            ? BoxDecoration(
            color: Colors.white, border: Border.all(color: maincolor))
            : const BoxDecoration(color: Color(0xffF4F4F4)),
        child: Center(
            child: Text(
              controller.position[i],
              style: TextStyle(
                fontSize: 16,
                color: (controller.isSelected[i] == true)
                    ? maincolor
                    : const Color(0xffB4B4B4),
              ),
            )),
      ),
    );
  }
}
