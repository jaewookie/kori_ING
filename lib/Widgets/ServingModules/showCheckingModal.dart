import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';
import 'package:provider/provider.dart';

class TrayCheckingModal extends StatefulWidget {
  const TrayCheckingModal({Key? key}) : super(key: key);

  @override
  State<TrayCheckingModal> createState() => _TrayCheckingModalState();
}

class _TrayCheckingModalState extends State<TrayCheckingModal> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? tableNumber;
  String? itemName;

  late var goalPosition = List<String>.empty();
  List<String> orderedItems = [];

  List<String> testItems = ['햄버거', '라면', '치킨', '핫도그', '미주문'];

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

  void showPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;
          return AlertDialog(
            content: SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('트레이가 가득 찼습니다.'),
                  Text('상품을 교체하시겠습니까?'),
                ],
              ),
            ),
            backgroundColor: Color(0xff2C2C2C),
            contentTextStyle: Theme.of(context).textTheme.headlineLarge,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Color(0xFFB7B7B7),
                  style: BorderStyle.solid,
                  width: 1,
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      _servingProvider.cancelTraySelection();
                      navPage(
                              context: context,
                              page: TraySelection3(),
                              enablePop: false)
                          .navPageToPage();
                    },
                    child: Text(
                      '상품 변경',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    style: TextButton.styleFrom(
                      // 라운드 채운 보더
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),side: BorderSide(
                        //   color: Colors.white,
                        //   width: 1
                        // )),
                      // 라인 보더
                        shape: LinearBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            top: LinearBorderEdge(size: 0.9),
                            end: LinearBorderEdge(size: 0.9)),
                        minimumSize:
                            Size(screenWidth * 0.27, screenHeight * 0.04)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('변경하지 않음',
                        style: Theme.of(context).textTheme.headlineMedium),
                    style: TextButton.styleFrom(
                      //라운드 보더
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),side: BorderSide(
                        //     color: Colors.white,
                        //     width: 1
                        // )),
                      // 라인 보더
                        shape: LinearBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            top: LinearBorderEdge(size: 0.9)),
                        minimumSize:
                            Size(screenWidth * 0.27, screenHeight * 0.04)),
                  ),
                ],
              )
            ],
            // actionsPadding: EdgeInsets.only(top: screenHeight * 0.001),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hamburger = "assets/images/serving_item_imgs/hamburger.png";
    hotDog = "assets/images/serving_item_imgs/hotDog.png";
    chicken = "assets/images/serving_item_imgs/chicken.png";
    ramyeon = "assets/images/serving_item_imgs/ramyeon.png";

    itemImages = [hamburger, hotDog, chicken, ramyeon];

    itemImagesList = [itemImages, itemImages, itemImages];
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ButtonWidth = screenWidth * 0.75;
    double ButtonHeight = screenHeight * 0.15;

    TextStyle? textFont2 = Theme.of(context).textTheme.headlineLarge;
    TextStyle? subTextFont = Theme.of(context).textTheme.headlineSmall;

    itemName = _servingProvider.menuItem;
    tableNumber = _servingProvider.tableNumber;

    table1 = _servingProvider.table1;
    table2 = _servingProvider.table2;
    table3 = _servingProvider.table3;

    item1 = _servingProvider.item1;
    item2 = _servingProvider.item2;
    item3 = _servingProvider.item3;

    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;

    List<String> tableDestinations = [];
    List<String> itemDestinations = [];
    List<String> trayDestinations = [];

    if (itemName == '햄버거') {
      itemNumber = 0;
    } else if (itemName == '핫도그') {
      itemNumber = 1;
    } else if (itemName == '치킨') {
      itemNumber = 2;
    } else if (itemName == '라면') {
      itemNumber = 3;
    } else {
      itemNumber.isNaN;
    }

    return Container(
      margin:
          EdgeInsets.fromLTRB(0, screenHeight * 0.1, 0, screenHeight * 0.15),
      child: Dialog(
        backgroundColor: Color(0xff000000),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Color(0xFFB7B7B7),
              style: BorderStyle.solid,
              width: 1,
            )),
        child: Container(
          margin: EdgeInsets.fromLTRB(
              0, screenHeight * 0.03, 0, screenHeight * 0.015),
          width: screenWidth,
          height: screenHeight,
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ButtonWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          print("table1 : $table1");
                          print("table2 : $table2");
                          print("table3 : $table3");
                          print(_servingProvider.itemImageList);

                          if ((_servingProvider.servedItem1 == false &&
                                  _servingProvider.servedItem2 == false) &&
                              _servingProvider.servedItem3 == false) {
                            showPopup(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TraySelection3()));
                          }
                          if (_servingProvider.tray1Select == true) {
                            _servingProvider.itemImageList![0] =
                            itemImagesList[0][itemNumber];
                            print('check item Number : ${itemNumber}');
                            print(
                                'check tray 1 : ${_servingProvider.itemImageList![0]}');
                            _servingProvider.tray1Select = false;
                            _servingProvider.servedItemTray1();
                          } else if (_servingProvider.tray2Select == true) {
                            _servingProvider.itemImageList![1] =
                            itemImagesList[1][itemNumber];
                            print('check item Number : ${itemNumber}');
                            print(
                                'check tray 2 : ${_servingProvider.itemImageList![1]}');
                            _servingProvider.tray2Select = false;
                            _servingProvider.servedItemTray2();
                          } else if (_servingProvider.tray3Select == true) {
                            _servingProvider.itemImageList![2] =
                            itemImagesList[2][itemNumber];
                            print('check item Number : ${itemNumber}');
                            print(
                                'check tray 3 : ${_servingProvider.itemImageList![2]}');
                            _servingProvider.tray3Select = false;
                            _servingProvider.servedItemTray3();
                          }
                          print(_servingProvider.servedItem1);
                          print(_servingProvider.servedItem2);
                          print(_servingProvider.servedItem3);
                        },
                        child: Text(
                          '상품 추가',
                          style: textFont2,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize:
                                Size(ButtonWidth * 0.45, ButtonHeight * 0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                    color: Color(0xFFB7B7B7),
                                    style: BorderStyle.solid,
                                    width: 2))),
                      ),
                      SizedBox(
                        width: ButtonWidth * 0.1,
                      ),
                      TextButton(
                        onPressed: () {
                          if (_servingProvider.tray1 == true) {
                            tableDestinations.add(table1!);
                            itemDestinations.add(item1!);
                            trayDestinations.add('1');
                            if (_servingProvider.tray2 == true) {
                              tableDestinations.add(table2!);
                              itemDestinations.add(item2!);
                              trayDestinations.add('2');
                              if (_servingProvider.tray3 == true) {
                                tableDestinations.add(table3!);
                                itemDestinations.add(item3!);
                                trayDestinations.add('3');
                              }
                            } else {
                              if (_servingProvider.tray3 == true) {
                                tableDestinations.add(table3!);
                                itemDestinations.add(item3!);
                                trayDestinations.add('3');
                              }
                            }
                          } else {
                            if (_servingProvider.tray2 == true) {
                              tableDestinations.add(table2!);
                              itemDestinations.add(item2!);
                              trayDestinations.add('2');
                              if (_servingProvider.tray3 == true) {
                                tableDestinations.add(table3!);
                                itemDestinations.add(item3!);
                                trayDestinations.add('3');
                              }
                            } else {
                              if (_servingProvider.tray3 == true) {
                                tableDestinations.add(table3!);
                                itemDestinations.add(item3!);
                                trayDestinations.add('3');
                              }
                            }
                          }
                          if (_servingProvider.trayCheckAll == true) {
                            tableDestinations.removeRange(1, 3);
                            itemDestinations.removeRange(1, 3);
                            trayDestinations.removeRange(1, 3);
                          }
                          _servingProvider.tableList = tableDestinations;
                          _servingProvider.itemList = itemDestinations;
                          _servingProvider.trayList = trayDestinations;
                          print('tableList : ${_servingProvider.tableList}');
                          print('itemList : ${_servingProvider.itemList}');
                          print('trayList : ${_servingProvider.trayList}');

                          PostApi(
                                  url: startUrl,
                                  endadr: navUrl,
                                  keyBody:
                                      'serving_${tableDestinations[0].toString()}')
                              .Posting();
                          _networkProvider.currentGoal =
                              '${tableDestinations[0].toString()}번 테이블';

                          navPage(
                                  context: context,
                                  page: NavigatorModule(),
                                  enablePop: true)
                              .navPageToPage();
                        },
                        child: Text(
                          '서빙 시작',
                          style: textFont2,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize:
                                Size(ButtonWidth * 0.45, ButtonHeight * 0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                    color: Color(0xFFB7B7B7),
                                    style: BorderStyle.solid,
                                    width: 2))),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.10),
                  height: screenHeight * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromRGBO(45, 45, 45, 45),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.fromBorderSide(BorderSide(
                                  color: Color(0xFFB7B7B7),
                                  style: BorderStyle.solid,
                                  width: 1))),
                          width: ButtonWidth,
                          height: ButtonHeight * 0.8,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                ButtonWidth * 0.075, 0, 0, ButtonHeight * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1번 트레이',
                                      style: textFont2,
                                    ),
                                  ],
                                ),
                                if (_servingProvider.tray1 == true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '테이블 : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '${_servingProvider.table1} 번',
                                        style: subTextFont,
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '테이블 : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '미지정',
                                        style: subTextFont,
                                      ),
                                    ],
                                  ),
                                if (_servingProvider.tray1 == true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '상품(메뉴) : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '${_servingProvider.item1}',
                                        style: subTextFont,
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '상품(메뉴) : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '미지정',
                                        style: subTextFont,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromRGBO(45, 45, 45, 45),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.fromBorderSide(BorderSide(
                                  color: Color(0xFFB7B7B7),
                                  style: BorderStyle.solid,
                                  width: 1))),
                          width: ButtonWidth,
                          height: ButtonHeight * 0.8,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                ButtonWidth * 0.075, 0, 0, ButtonHeight * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2번 트레이',
                                      style: textFont2,
                                    ),
                                  ],
                                ),
                                if (_servingProvider.tray2 == true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '테이블 : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '${_servingProvider.table2} 번',
                                        style: subTextFont,
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '테이블 : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '미지정',
                                        style: subTextFont,
                                      ),
                                    ],
                                  ),
                                if (_servingProvider.tray2 == true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '상품(메뉴) : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '${_servingProvider.item2}',
                                        style: subTextFont,
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '상품(메뉴) : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '미지정',
                                        style: subTextFont,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromRGBO(45, 45, 45, 45),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.fromBorderSide(BorderSide(
                                  color: Color(0xFFB7B7B7),
                                  style: BorderStyle.solid,
                                  width: 1))),
                          width: ButtonWidth,
                          height: ButtonHeight * 0.8,
                          child: Padding(
                            // padding: EdgeInsets.only(left: ButtonWidth*0.1),
                            padding: EdgeInsets.fromLTRB(
                                ButtonWidth * 0.075, 0, 0, ButtonHeight * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3번 트레이',
                                      style: textFont2,
                                    ),
                                  ],
                                ),
                                if (_servingProvider.tray3 == true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '테이블 : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '${_servingProvider.table3} 번',
                                        style: subTextFont,
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '테이블 : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '미지정',
                                        style: subTextFont,
                                      ),
                                    ],
                                  ),
                                if (_servingProvider.tray3 == true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '상품(메뉴) : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '${_servingProvider.item3}',
                                        style: subTextFont,
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '상품(메뉴) : ',
                                        style: subTextFont,
                                      ),
                                      Text(
                                        '미지정',
                                        style: subTextFont,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
