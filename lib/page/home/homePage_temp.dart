// import 'package:cau_gameduo/components/Color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cau_gameduo/controller/home/homePageController.dart';
// import '../../components/SizedBox.dart';
//
// class homePage extends GetView<homePageController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//               Image.asset(
//                 "images/logo.png",
//                 width: 50,
//                 height: 50,
//               ),
//               Sbox(10, 0),
//               Text('게임해듀오',
//                   style: TextStyle(
//                     color: maincolor,
//                     fontSize: 14,
//                   )),
//             ],
//           )),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: ScrollConfiguration(
//           behavior: const ScrollBehavior().copyWith(overscroll: false),
//           child: ListView(children: [
//             const Text('별점이 높은 유저를 만나보세요',
//                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
//             Sbox(0, 5),
//             const Text('같이 게임을 즐길 듀오를 구해보세요',
//                 style: TextStyle(
//                   fontSize: 12,
//                 )),
//             Sbox(0, 10),
//             //가로 리스트
//             ListView.separated(
//               scrollDirection: Axis.horizontal,
//               controller: controller.scrollController.value,
//               separatorBuilder: (_, index) => Divider(),
//               itemCount: controller.data.length+1,
//               itemBuilder: (_, index){
//                 if(index<controller.data.length){
//                   var datum=controller.data[index];
//                   return Material(
//                     elevation: 10.0,
//                     child: Container(
//                       height: 193,
//                       width: 120,
//                       margin: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           color: const Color(0xFFF6F6F6),
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             width: 1,
//                             color: const Color(0xffD1D1D1),
//                           )),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius:
//                               BorderRadius.circular(20), // Image border
//                               child: SizedBox.fromSize(
//                                 size: Size.fromRadius(60),
//                                 child: Image.network(
//                                   //프로필 사진
//                                   controller.myprofile.image,
//                                 ),
//                               ),
//                             ),
//                             Sbox(0, 5),
//                             Text(
//                               controller.myprofile.nick,
//                               style: const TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.bold),
//                             ),
//                             Sbox(0, 5),
//                             Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     //랭크 사진
//                                     "images/point.png",
//                                     width: 18,
//                                     height: 18,
//                                   ),
//                                   Sbox(5, 0),
//                                   Text(
//                                     '티어',
//                                     style: TextStyle(
//                                         fontSize: 12, fontWeight: FontWeight.bold),
//                                   ),
//                                 ]),
//                             Sbox(0, 5),
//                             Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   //Text(controller.myprofile.point,),
//                                   Sbox(5, 0),
//                                   Image.asset(
//                                     "images/point.png",
//                                     width: 18,
//                                     height: 18,
//                                   ),
//                                 ]),
//                             Sbox(0, 5)
//                           ],
//                         ),
//                       ),
//                   );
//                 }
//                 if (controller.isRequesting.value || controller.isLoading.value) {
//                   return Center(child: RefreshProgressIndicator());
//                 }
//                 return Container(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         Text('데이터의 마지막 입니다'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             //세로 list
//             ListView.separated(
//               scrollDirection: Axis.vertical,
//               controller: controller.scrollController.value,
//               separatorBuilder: (_, index) => Divider(),
//               itemCount: controller.data.length+1,
//               itemBuilder: (_, index){
//                 if(index<controller.data.length){
//                   var datum=controller.data[index];
//                   return Material(
//                       elevation: 10.0,
//                       child: Container(
//                         width: double.infinity,
//                         height: 90,
//                         margin: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             color: const Color(0xFFF6F6F6),
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               width: 1,
//                               color: const Color(0xFFd1d1d1),
//                             )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius:
//                               BorderRadius.circular(15), // Image border
//                               child: SizedBox.fromSize(
//                                 size: Size.fromRadius(45),
//                                 child: Image.network(
//                                   //프로필 사진
//                                   controller.myprofile.image,
//                                 ),
//                               ),
//                             ),
//                             Sbox(20, 0),
//                             Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     controller.myprofile.nick,
//                                     style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Sbox(0, 15),
//                                   Container(
//                                     width: 220,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Image.asset(
//                                               //랭크 사진
//                                               "images/point.png",
//                                               width: 20,
//                                               height: 20,
//                                             ),
//                                             Text('  플레티넘'),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text('300 PT  '),
//                                             Image.asset(
//                                               "images/point.png",
//                                               width: 20,
//                                               height: 20,
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ]),
//                           ],
//                         ),
//                       ),
//                   );
//                 }
//                 if (controller.isRequesting.value || controller.isLoading.value) {
//                   return Center(child: RefreshProgressIndicator());
//                 }
//                 return Container(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         Text('데이터의 마지막 입니다'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
