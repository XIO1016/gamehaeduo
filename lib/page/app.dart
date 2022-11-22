import 'package:cau_gameduo/page/home/homePage.dart';
import 'package:cau_gameduo/page/myPage/myPage.dart';
import 'package:cau_gameduo/page/seachDuo/searchDuoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/bottomNavController.dart';

class App extends GetView<BottomNavController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(index: controller.pageIndex.value, children: [
            homePage(),
            //TODO 여기에 navigation에 따른 화면들 넣기
            searchDuoPage(),
            Container(
              child: Center(
                child: Text('chat'),
              ),
            ),
            MyPage()
          ]),
          bottomNavigationBar: Container(
            height: 64,
            color: Colors.white,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: controller.pageIndex.value,
              elevation: 5,
              onTap: controller.changeBottomNav,
              selectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.group,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.group,
                    size: 28,
                  ),
                  label: '듀오 찾기',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.chat,
                    size: 28,
                  ),
                  label: '채팅',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    size: 28,
                  ),
                  label: '프로필',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
