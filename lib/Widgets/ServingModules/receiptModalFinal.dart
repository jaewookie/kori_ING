import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Widgets/OrderedMenuButtons.dart';
import 'package:kori_test_refactoring/screens/modules/mainScreenButtonsFinal.dart';
import 'package:provider/provider.dart';

import '../../Providers/ServingModel.dart';
import 'showCheckingModal.dart';

class SelectReceiptModalFinal extends StatefulWidget {
  const SelectReceiptModalFinal({Key? key}) : super(key: key);

  @override
  State<SelectReceiptModalFinal> createState() => _SelectReceiptModalFinalState();
}

class _SelectReceiptModalFinalState extends State<SelectReceiptModalFinal> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? tableNumber;
  String? itemName;

  late var goalPosition = List<String>.empty();
  List<String> orderedItems = [];

  List<String> testItems = ['햄버거', '라면', '치킨', '핫도그', '미주문'];

  // 배경 화면
  String receiptSelectBG = 'final_assets/screens/koriZFinalReceiptSelect.png';

  // 코리 바디 및 트레이 사진
  late String koriBody;
  late String servingTray1;
  late String servingTray2;
  late String servingTray3;

  // 상품 사진
  late String hamburger;
  late String hotDog;
  late String chicken;
  late String ramyeon;

  // 상품 구분 번호
  // late int itemNumber;
  int itemNumber = 0;

  // 상품 목록
  late List<List> itemImagesList; // 트레이 1, 2, 3 다발 리스트
  late List<String> itemImages;
  late int trayNumber;

  // 트레이 하이드 앤 쇼
  bool? offStageTray1;
  bool? offStageTray2;
  bool? offStageTray3;

  // 음식 하이드 앤 쇼
  bool? servedItem1;
  bool? servedItem2;
  bool? servedItem3;

  //트레이별 선택 테이블 넘버
  String? table1;
  String? table2;
  String? table3;

  //트레이별 선택 메뉴
  String? item1;
  String? item2;
  String? item3;

  //restAPI url
  String? startUrl;
  String? navUrl;

  //디버그
  bool _debugTray = false;

  late bool receiptModeOn;

  void showCheckingPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return TrayCheckingModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    itemName = _servingProvider.menuItem;
    tableNumber = _servingProvider.tableNumber;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.4;
    double textButtonHeight = screenHeight * 0.15;

    goalPosition = _networkProvider.goalPosition;

    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineLarge;

    // if (orderedItems.length == 0) {
    //   for (int i = 0; i < _networkProvider.goalPosition.length; i++) {
    //     orderedItems.add(testItems[Random().nextInt(testItems.length)]);
    //     print(orderedItems);
    //   }
    // }

    return Container(
      child: Dialog(
        backgroundColor: Color(0xff000000),
        child: Stack(children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              border: Border.fromBorderSide((BorderSide(
                color: Colors.white,
                width: 1
              ))),
                image: DecorationImage(
                    image: AssetImage(receiptSelectBG), fit: BoxFit.cover)),
          ),
          Positioned(
              left: 1176 * 0.75,
              top: 307 * 0.75,
              child: Container(
                width: 48,
                height: 48,
                // color: Colors.white,
                // decoration: BoxDecoration(
                //   border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 1))
                // ),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: () {
                    Navigator.pop(context);
                    _servingProvider.item1 = "";
                    _servingProvider.item2 = "";
                    _servingProvider.item3 = "";

                    print(_servingProvider.item1);
                    print(_servingProvider.item2);
                    print(_servingProvider.item3);
                  },
                  child: null,
                ),
              )),
          Positioned(
            child: FinalMainScreenButtons(screens: 5,),)
        ]),
      ),
    );
  }
}







//Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               for (int i = 0; i < (goalPosition.length / 2); i++)
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceEvenly,
//                       children: [
//                         if ((2 * i) + 2 <= goalPosition.length)
//                           for (int j = (2 * i);
//                           j < ((2 * i) + 2);
//                           j++)
//                             Row(
//                               children: [
//                                 SizedBox(),
//                                 OrderedMenuButtons(
//                                     onPressed: () {
//                                       showCheckingPopup(context);
//                                       setState(() {
//                                         _servingProvider.menuItem =
//                                         orderedItems[j];
//                                         _servingProvider.tableNumber =
//                                         goalPosition[j];
//                                       });
//
//                                       print(orderedItems[j]);
//
//                                       if (_servingProvider
//                                           .tray1Select ==
//                                           true) {
//                                         _servingProvider.setTray1();
//                                       } else if (_servingProvider
//                                           .tray2Select ==
//                                           true) {
//                                         _servingProvider.setTray2();
//                                       } else if (_servingProvider
//                                           .tray3Select ==
//                                           true) {
//                                         _servingProvider.setTray3();
//                                       }
//                                     },
//                                     buttonText: goalPosition[j],
//                                     itemName: orderedItems[j],
//                                     buttonWidth: textButtonWidth,
//                                     buttonHeight: textButtonHeight,
//                                     buttonColor: Color.fromRGBO(
//                                         45, 45, 45, 45),
//                                     screenWidth: screenWidth,
//                                     screenHeight: screenHeight,
//                                     buttonFont: tableButtonFont),
//                               ],
//                             )
//                         else
//                           Row(
//                             children: [
//                               OrderedMenuButtons(
//                                   onPressed: () {
//                                     // Navigator.pop(context);
//                                     showCheckingPopup(context);
//                                     print(orderedItems.last);
//                                     setState(() {
//                                       _servingProvider.menuItem =
//                                           orderedItems.last;
//                                       _servingProvider.tableNumber =
//                                           goalPosition.last;
//                                     });
//
//                                     if (_servingProvider
//                                         .tray1Select ==
//                                         true) {
//                                       _servingProvider.setTray1();
//                                     } else if (_servingProvider
//                                         .tray2Select ==
//                                         true) {
//                                       _servingProvider.setTray2();
//                                     } else if (_servingProvider
//                                         .tray3Select ==
//                                         true) {
//                                       _servingProvider.setTray3();
//                                     }
//                                   },
//                                   buttonText: goalPosition.last,
//                                   itemName: orderedItems.last,
//                                   buttonWidth: textButtonWidth,
//                                   buttonHeight: textButtonHeight,
//                                   buttonColor:
//                                   Color.fromRGBO(45, 45, 45, 45),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   buttonFont: tableButtonFont),
//                               SizedBox(
//                                 width: textButtonWidth * 1.1,
//                                 height: textButtonHeight * 0.7,
//                               )
//                             ],
//                           )
//                       ],
//                     ),
//                     SizedBox(
//                       height: screenHeight * 0.02,
//                     ),
//                   ],
//                 ),
//             ],
//           )
