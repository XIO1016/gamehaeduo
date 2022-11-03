import 'package:cau_gameduo/components/Color.dart';
import 'package:cau_gameduo/page/login/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/init_biinding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
