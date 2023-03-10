import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/login/LoginController.dart';
import 'package:cau_gameduo/page/login/signUpPage1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cau_gameduo/page/login/kakao_loginV1.dart';

import '../../components/SizedBox.dart';


class LoginPage extends GetView<LoginController> {

  final kakaoLogin = KakaoLogin();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Sbox(0, 50),
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
                    Sbox(0, 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: maincolor,
                            controller: controller.idController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey), //<-- SEE HERE
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: maincolor)),
                              prefixIcon: const Icon(
                                Icons.person_rounded,
                              ),
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
                            obscureText: true,
                            controller: controller.pwController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey), //<-- SEE HERE
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: maincolor)),
                              prefixIcon: const Icon(
                                      Icons.https,
                                    ),
                              hintText: "비밀번호",
                              hintStyle: const TextStyle(
                                  fontSize: 15, color: Color(0xff727272)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Sbox(0, 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.Login();
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 60),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                backgroundColor: maincolor,
                                padding: const EdgeInsets.only(
                                    bottom: 5, left: 25, right: 25)),
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Sbox(0, 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('아직 계정이 없으신가요? ',
                            style: TextStyle(color: Colors.grey)),
                        TextButton(
                          child: Text('회원가입',
                              style: TextStyle(
                                  color: maincolor,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage1()));
                          },
                        )
                      ],
                    ),
                    Sbox(0, 10),
                    Stack(alignment: Alignment.center, children: [
                      const Divider(color: Color(0xffF4F4F4), thickness: 1.0),
                      Container(
                        width: 50,
                        height: 30,
                        color: Colors.white,
                      ),
                      const Text('또는', style: TextStyle(color: Color(0xffC4C4C4))),
                    ]),
                    Sbox(0, 30),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                // width: 300,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color(0xffFEE500),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))
                                    // button text
                                    ),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "images/kakao_logo.png",
                                    ),
                                    const Center(
                                      child: Text('카카오로 시작하기',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xff191600))),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                kakaoLogin.login();
                              }),
                        ),
                      ],
                    ),
                    Sbox(0, 30),
                    Column(
                      //텍스트 밑으로 넘어갈 때 디자인용
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            const Text(
                              '로그인하면 게임해듀오 ',
                              style: TextStyle(fontSize: 11),
                            ),
                            GestureDetector(
                                child: const Text("이용약관",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  launchUrl(
                                    Uri.parse('https://gamehaeduo.shop/policy'),
                                  );
                                }),
                            const Text(
                              '에 동의하는 것으로 간주됩니다.',
                              style: TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                        Sbox(0, 2),
                        Wrap(
                          children: [
                            const Text(
                              '회원정보 처리 방식은 ',
                              style: TextStyle(fontSize: 11),
                            ),
                            GestureDetector(
                                child: const Text("개인정보취급방침",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  launchUrl(
                                    Uri.parse(
                                        'https://gamehaeduo.shop/privacy'),
                                  );
                                }),
                            const Text(
                              '에서 확인 가능합니다.',
                              style: TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

    );
  }
}
