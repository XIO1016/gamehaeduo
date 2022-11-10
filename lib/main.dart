import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage1.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage2.dart';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:cau_gameduo/page/login/signUpPage.dart';
import 'package:cau_gameduo/page/login/startPage.dart';
import 'package:cau_gameduo/page/myPage/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'binding/init_biinding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    KakaoSdk.init(nativeAppKey: '1d707f03c04129f8ed599103dcf31684');
    return GetMaterialApp(
      title: '복어',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: maincolor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Color(0xff505050), fontFamily: 'SD'),
        ),
      ),
      initialBinding: InitBinding(),
      home: const SignUpPage(),
      getPages: [
        GetPage(name: '/start', page: () => StartPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/home', page: () => homePage()),
        GetPage(name: '/becomeplayer1', page: () => BecomePlayerPage1()),
        GetPage(name: '/becomeplayer2', page: () => BecomePlayerPage2()),
        GetPage(name: '/profile', page: () => profilePage()),
      ],
    );
  }
}
