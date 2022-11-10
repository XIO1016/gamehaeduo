import 'package:cau_gameduo/page/login/kakao_loginV1.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/SizedBox.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final kakaoLogin = KakaoLogin();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Sbox(double.infinity, 0),
              Image(
                image: AssetImage('images/lol_icon.png'),
                width: 139,
                height: 150,
              ),
              Sbox(0, 10),
              Text(
                '게임해듀오',
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF545DAD),
                    fontWeight: FontWeight.bold),
              ),
              Sbox(0, 280),
              GestureDetector(
                  child: Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image:
                              AssetImage("images/kakao_login_medium_wide.png"),
                          fit: BoxFit.cover,
                        ), // button text
                      )),
                  onTap: () {
                    kakaoLogin.login();
                  }),
              Sbox(0, 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '로그인하면 게임해듀오 ',
                    style: TextStyle(fontSize: 11),
                  ),
                  GestureDetector(
                      child: Text("이용약관",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        launchUrl(
                          Uri.parse('https://gamehaeduo.shop/policy'),
                        );
                      }),
                  Text(
                    '에 동의하는 것으로 간주됩니다.',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
              Sbox(0, 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '게임해듀오 회원정보 처리 방식은 ',
                    style: TextStyle(fontSize: 11),
                  ),
                  GestureDetector(
                      child: Text("개인정보취급방침",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        launchUrl(
                          Uri.parse('https://gamehaeduo.shop/privacy'),
                        );
                      }),
                  Text(
                    '에서 확인 가능합니다.',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
              Sbox(0, 40),
            ]),
      ),
    );
  }
}
