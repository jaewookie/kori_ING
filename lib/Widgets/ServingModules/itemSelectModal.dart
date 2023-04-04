import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Widgets/OrderedMenuButtons.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectModal.dart';
import 'package:provider/provider.dart';

import '../../Providers/ServingModel.dart';
import 'showCheckingModal.dart';

class SelectItemModal extends StatefulWidget {
  const SelectItemModal({Key? key}) : super(key: key);

  @override
  State<SelectItemModal> createState() => _SelectItemModalState();
}

class _SelectItemModalState extends State<SelectItemModal> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? tableNumber;
  String? itemName;

  late var goalPosition = List<String>.empty();
  List<String> orderedItems = [];

  List<String> menuItems = ['햄버거', '라면', '치킨', '핫도그'];

  String hamburgerImg = 'assets/images/serving_menu_img/menu_hamburger.png';
  String ramyeonImg = 'assets/images/serving_menu_img/menu_ramyeon.png';
  String chickenImg = 'assets/images/serving_menu_img/menu_chicken.png';
  String hotDogImg = 'assets/images/serving_menu_img/menu_hotDog.png';

  late List<String> menuImgItems;

  // 배경 화면
  late String backgroundImage;

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

  void showSelectTablePopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SelectTableModal();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuImgItems = [hamburgerImg, ramyeonImg, chickenImg, hotDogImg];
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

    TextStyle? tableFont = Theme.of(context).textTheme.displaySmall;
    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineLarge;

    return Container(
      margin:
          EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, screenHeight * 0.15),
      child: Dialog(
        backgroundColor: Color(0xff000000),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Color(0xFFB7B7B7),
              style: BorderStyle.solid,
              width: 1,
            )),
        child:Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _servingProvider.item1 = "";
                    _servingProvider.item2 = "";
                    _servingProvider.item3 = "";

                    print(_servingProvider.item1);
                    print(_servingProvider.item2);
                    print(_servingProvider.item3);
                  },
                  icon: Icon(Icons.cancel_presentation_outlined),
                  color: const Color(0xffF0F0F0),
                  iconSize: 60,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "상품을 선택 해 주세요",
                        style: tableFont,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, screenHeight * 0.04, 0, screenHeight * 0.015),
                  width: screenWidth,
                  height: screenHeight * 0.64,
                  child: Scrollbar(
                    thickness: 4.0,
                    radius: Radius.circular(8.0),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 1,
                        itemBuilder: (BuildContext, int index) {
                          return Column(
                            children: [
                              for (int j = 0; j < (menuItems.length) / 2; j++)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _servingProvider.menuItem =
                                              menuItems[(2*j)];
                                              if (_servingProvider.tray1Select ==
                                                  true) {
                                                _servingProvider.setItemTray1();
                                                print('setItremTray1');
                                                print('${_servingProvider.menuItem}');
                                              } else if (_servingProvider
                                                  .tray2Select ==
                                                  true) {
                                                _servingProvider.setItemTray2();
                                              } else if (_servingProvider
                                                  .tray3Select ==
                                                  true) {
                                                _servingProvider.setItemTray3();
                                              }
                                            });
                                            Navigator.pop(context);
                                            showSelectTablePopup(context);
                                            print(_servingProvider.menuItem);
                                            print('tray1 : ${_servingProvider.item1}');
                                            print('tray2 : ${_servingProvider.item2}');
                                            print('tray3 : ${_servingProvider.item3}');
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: screenHeight * 0.2,
                                                width: screenWidth * 0.4,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          menuImgItems[(2 * j)]),
                                                      fit: BoxFit.fitHeight),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0,
                                                    screenHeight * 0.01,
                                                    0,
                                                    screenHeight * 0.01),
                                                width: screenWidth * 0.37,
                                                height: 3,
                                                color: Colors.white,
                                              ),
                                              Container(
                                                child: Text(
                                                  menuItems[(2 * j)],
                                                  style: tableButtonFont,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: screenHeight * 0.01),
                                                width: screenWidth * 0.37,
                                                height: 3,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        FilledButton(
                                            style: FilledButton.styleFrom(
                                                backgroundColor:
                                                Colors.transparent),
                                            onPressed: () {
                                              setState(() {
                                                _servingProvider.menuItem =
                                                menuItems[(2*j)+1];
                                                if (_servingProvider.tray1Select ==
                                                    true) {
                                                  _servingProvider.setItemTray1();
                                                } else if (_servingProvider
                                                    .tray2Select ==
                                                    true) {
                                                  _servingProvider.setItemTray2();
                                                } else if (_servingProvider
                                                    .tray3Select ==
                                                    true) {
                                                  _servingProvider.setItemTray3();
                                                }
                                              });
                                              Navigator.pop(context);
                                              showSelectTablePopup(context);
                                              print(_servingProvider.menuItem);
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                    height: screenHeight * 0.2,
                                                    width: screenWidth * 0.4,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                menuImgItems[
                                                                (2 * j) + 1]),
                                                            fit:
                                                            BoxFit.fitHeight))),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0,
                                                      screenHeight * 0.01,
                                                      0,
                                                      screenHeight * 0.01),
                                                  width: screenWidth * 0.37,
                                                  height: 3,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  child: Text(
                                                    menuItems[(2 * j) + 1],
                                                    style: tableButtonFont,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: screenHeight * 0.01),
                                                  width: screenWidth * 0.37,
                                                  height: 3,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                    (j + 1 < (menuItems.length) / 2)
                                        ? Container(
                                      height: screenHeight * 0.04,
                                    )
                                        : Container()
                                  ],
                                ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '상품 선택 화면',
                  style: TextStyle(
                      fontSize: 80, color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}