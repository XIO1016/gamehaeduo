import 'package:cau_gameduo/binding/init_bindings.dart';
import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/page/app.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage1.dart';
import 'package:cau_gameduo/page/becomePlayer/becomePlayerPage2.dart';
import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:cau_gameduo/page/myPage/myPage.dart';
import 'package:cau_gameduo/page/myPage/settingPage.dart';
import 'package:cau_gameduo/page/login/signUpPage.dart';
import 'package:cau_gameduo/page/login/startPage.dart';
import 'package:cau_gameduo/page/seachDuo/searchDuoPage.dart';
import 'package:cau_gameduo/page/duoProfile/duoProfilePage.dart';
import 'package:cau_gameduo/page/message/messageMainPage.dart';
import 'package:cau_gameduo/page/message/messageListPage.dart';
import 'package:cau_gameduo/page/message/messagePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

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
      title: '게임해듀오',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: maincolor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Color(0xff505050), fontFamily: 'SD'),
        ),
      ),
      initialBinding: InitBinding(),
      home: homePage(),
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(name: '/start', page: () => StartPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/home', page: () => homePage()),
        GetPage(name: '/becomeplayer1', page: () => BecomePlayerPage1()),
        GetPage(name: '/becomeplayer2', page: () => BecomePlayerPage2()),
        GetPage(name: '/mypage', page: () => MyPage()),
        GetPage(name: '/mypage', page: () => SettingPage()),
        GetPage(name: '/search', page: () => searchDuoPage()),
        GetPage(name: '/search', page: () => duoProfilePage()),
        GetPage(name: '/message', page: () => MessageMainPage()),
        GetPage(name: '/message', page: () => MessageListPage()),
        GetPage(name: '/message', page: () => MessagePage()),
      ],
    );
  }
}
