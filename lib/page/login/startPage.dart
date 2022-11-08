import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/controller/login/SignUpController.dart';
import 'package:cau_gameduo/page/login/kakao_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/SizedBox.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final kakoLogin = KakaoLogin();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              icon: Image.asset('images/kakao_login_medium_wide.png'),
              iconSize: 300,
              onPressed: () {
                kakoLogin.login();
              },
            )
          ]),
        ),
      ),
    );
  }
}

// mage : Image.asset("kakao_login_large_wide.png")
