import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving2/ServingMenu2.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:provider/provider.dart';

class TraySelection2 extends StatefulWidget {
  const TraySelection2({Key? key}) : super(key: key);

  @override
  State<TraySelection2> createState() => _TraySelection2State();
}

class _TraySelection2State extends State<TraySelection2> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? tableNumber;
  String? itemName;

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
  late int itemNumber;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    backgroundImage = "assets/images/KoriBackgroundImage_v1.png";
    koriBody = "assets/images/serving_img/kori_body.png";
    servingTray1 = "assets/images/serving_img/serving_tray1.png";
    servingTray2 = "assets/images/serving_img/serving_tray2.png";
    servingTray3 = "assets/images/serving_img/serving_tray3.png";

    hamburger = "assets/images/serving_item_imgs/hamburger.png";
    hotDog = "assets/images/serving_item_imgs/hotDog.png";
    chicken = "assets/images/serving_item_imgs/chicken.png";
    ramyeon = "assets/images/serving_item_imgs/ramyeon.png";

    itemImages = [hamburger, hotDog, chicken, ramyeon];

    itemImagesList = [itemImages, itemImages, itemImages];
  }

  void showPopup(context, int trayNumbers) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('선반위 상품을 변경하시겠습니까?'),
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
                        if (trayNumbers == 1) {
                          _servingProvider.trayCheckAll = false;
                          _servingProvider.setTray1();
                        } else if (trayNumbers == 2) {
                          _servingProvider.trayCheckAll = false;
                          _servingProvider.setTray2();
                        } else if (trayNumbers == 3) {
                          _servingProvider.trayCheckAll = false;
                          _servingProvider.setTray3();
                        } else {
                          _servingProvider.trayCheckAll = true;
                          _servingProvider.setTrayAll();
                        }

                        setState(() {
                          _servingProvider.itemImageList![trayNumbers - 1] =
                              itemImagesList[trayNumbers - 1][itemNumber];
                        });

                        Navigator.pop(context);
                      },
                      child: Text('확인')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('취소'))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    itemName = _servingProvider.menuItem;
    tableNumber = _servingProvider.tableNumber;

    offStageTray1 = _servingProvider.attachedTray1;
    offStageTray2 = _servingProvider.attachedTray2;
    offStageTray3 = _servingProvider.attachedTray3;

    servedItem1 = _servingProvider.servedItem1;
    servedItem2 = _servingProvider.servedItem2;
    servedItem3 = _servingProvider.servedItem3;

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

    print(_servingProvider.itemImageList);

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

    print('item :: ${itemName}');
    print(tableNumber);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.6;
    double textButtonHeight = screenHeight * 0.08;

    TextStyle? textFont1 = Theme.of(context).textTheme.displaySmall;
    TextStyle? textFont2 = Theme.of(context).textTheme.headlineLarge;
    TextStyle? buttonFont = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            navPage(context: context, page: ServingMenu2(), enablePop: false)
                .navPageToPage();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Color(0xffB7B7B7),
          iconSize: screenHeight * 0.03,
          alignment: Alignment.centerRight,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            onPressed: () {
              navPage(context: context, page: ServiceScreen(), enablePop: false)
                  .navPageToPage();
            },
            icon: Icon(
              Icons.home_outlined,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.03,
            alignment: Alignment.center,
          ),
          Icon(Icons.battery_charging_full,
              color: Colors.teal, size: screenHeight * 0.03),
          SizedBox(width: screenWidth * 0.03)
        ],
        toolbarHeight: screenHeight * 0.045,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        child: Stack(
          children: [
            //트레이1 사진
            Offstage(
              offstage: offStageTray1!,
              child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(servingTray1)),
                  ),
                  margin: EdgeInsets.only(top: screenHeight * 0.05),
                  child: SizedBox()),
            ),
            //트레이2 사진
            Offstage(
              offstage: offStageTray2!,
              child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(servingTray2)),
                  ),
                  margin: EdgeInsets.only(top: screenHeight * 0.05),
                  child: SizedBox()),
            ),
            //트레이3 사진
            Offstage(
              offstage: offStageTray3!,
              child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(servingTray3)),
                  ),
                  margin: EdgeInsets.only(top: screenHeight * 0.05),
                  child: SizedBox()),
            ),
            //기능적 부분
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(koriBody)),
              ),
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Stack(children: [
                // 상단 문구 및 현재 선택 상품, 테이블 번호 표시
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('상품을 선반에 올린 후 ', style: textFont1),
                            Text('선반을 선택해주세요.', style: textFont1),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: screenWidth * 0.15),
                          child: Column(
                            children: [
                              Text('${tableNumber!}번 테이블 ', style: textFont2),
                              Text('$itemName', style: textFont2),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // 작동 버튼 묶음
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 디버그 버튼 트레이 활성화용
                    Offstage(
                      offstage: _debugTray,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('트레이 활성화 버튼'),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _servingProvider.stickTray1();
                                });
                              },
                              child: Text('Tray1', style: buttonFont),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  fixedSize: Size(textButtonWidth * 0.2,
                                      textButtonHeight * 0.5),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFB7B7B7),
                                          style: BorderStyle.solid,
                                          width: 10)))),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _servingProvider.stickTray2();
                                });
                              },
                              child: Text('Tray2', style: buttonFont),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  fixedSize: Size(textButtonWidth * 0.2,
                                      textButtonHeight * 0.5),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFB7B7B7),
                                          style: BorderStyle.solid,
                                          width: 10)))),
                          SizedBox(
                            height: screenHeight * 0.02,
                            child: Text('$offStageTray2'),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _servingProvider.stickTray3();
                                });
                              },
                              child: Text('Tray3', style: buttonFont),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  fixedSize: Size(textButtonWidth * 0.2,
                                      textButtonHeight * 0.5),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFB7B7B7),
                                          style: BorderStyle.solid,
                                          width: 10)))),
                          SizedBox(
                            height: screenHeight * 0.3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
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
                              print(_servingProvider.tableList);
                              print(_servingProvider.itemList);
                              print(_servingProvider.trayList);

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
                            child: Text('서빙 시작', style: buttonFont),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(textButtonWidth * 0.3,
                                    textButtonHeight * 0.7),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 10)))),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        TextButton(
                            onPressed: () {
                              navPage(
                                      context: context,
                                      page: ServingMenu2(),
                                      enablePop: false)
                                  .navPageToPage();
                            },
                            child: Text('상품 추가', style: buttonFont),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(textButtonWidth * 0.3,
                                    textButtonHeight * 0.7),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 10)))),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _servingProvider.clearAllTray();
                              });
                            },
                            child: Text('트레이 초기화', style: buttonFont),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(textButtonWidth * 0.3,
                                    textButtonHeight * 0.7),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 10)))),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                      ],
                    ),
                  ],
                ),
                //트레이1
                Offstage(
                  offstage: offStageTray1!,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(screenWidth * 0.470,
                            screenHeight * 0.320, screenWidth * 0.495, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFF11ffFF),
                                style: BorderStyle.solid,
                                width: 5))),
                        child: Offstage(
                            offstage: servedItem1!,
                            child: Text(
                              '$table1 번',
                              style: buttonFont,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            screenWidth * 0.5,
                            screenHeight * 0.320,
                            screenWidth * 0.35,
                            screenHeight * 0.583),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFffB7),
                                style: BorderStyle.solid,
                                width: 5))),
                      ),
                      Offstage(
                        offstage: servedItem1!,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(
                                screenWidth * 0.5,
                                screenHeight * 0.320,
                                screenWidth * 0.35,
                                screenHeight * 0.583),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      _servingProvider.itemImageList![0]),
                                  fit: BoxFit.fitHeight),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            screenWidth * 0.4,
                            screenHeight * 0.30,
                            screenWidth * 0.25,
                            screenHeight * 0.55),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFB7B7),
                                style: BorderStyle.solid,
                                width: 10))),
                        child: TextButton(
                            onPressed: () {
                              print("tapped");
                              if (_servingProvider.tray1 == true &&
                                  tableNumber != table1) {
                                showPopup(context, 1);
                              } else if (_servingProvider.tray1 == true &&
                                  tableNumber == table1) {
                                _servingProvider.clearTray1();
                                setState(() {});
                              } else {
                                _servingProvider.setTray1();
                                setState(() {
                                  _servingProvider.itemImageList![0] =
                                      itemImagesList[0][itemNumber];
                                  _servingProvider.servedItemTray1();
                                });
                              }
                              print(_servingProvider.item1);
                              print(_servingProvider.itemImageList);
                            },
                            child: Container(),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize:
                                    Size(textButtonWidth, textButtonHeight),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 10)))),
                      ),
                    ],
                  ),
                ),
                //트레이2
                Offstage(
                  offstage: offStageTray2!,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(screenWidth * 0.470,
                            screenHeight * 0.410, screenWidth * 0.495, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFF11ffFF),
                                style: BorderStyle.solid,
                                width: 5))),
                        child: Offstage(
                            offstage: servedItem2!,
                            child: Text(
                              '$table2 번',
                              style: buttonFont,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            screenWidth * 0.5,
                            screenHeight * 0.410,
                            screenWidth * 0.35,
                            screenHeight * 0.492),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFffB7),
                                style: BorderStyle.solid,
                                width: 5))),
                      ),
                      Offstage(
                        offstage: servedItem2!,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              screenWidth * 0.5,
                              screenHeight * 0.410,
                              screenWidth * 0.35,
                              screenHeight * 0.492),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    _servingProvider.itemImageList![1]),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(screenWidth * 0.4,
                            screenHeight * 0.390, screenWidth * 0.25, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFB7B7),
                                style: BorderStyle.solid,
                                width: 10))),
                        child: TextButton(
                            onPressed: () {
                              if (_servingProvider.tray2 == true &&
                                  tableNumber != table2) {
                                showPopup(context, 2);
                              } else if (_servingProvider.tray2 == true &&
                                  tableNumber == table2) {
                                _servingProvider.clearTray2();
                                setState(() {});
                              } else {
                                _servingProvider.setTray2();
                                setState(() {
                                  _servingProvider.itemImageList![1] =
                                      itemImagesList[1][itemNumber];
                                  _servingProvider.servedItemTray2();
                                });
                              }
                            },
                            child: Container(),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize:
                                    Size(textButtonWidth, textButtonHeight),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 10)))),
                      ),
                    ],
                  ),
                ),
                //트레이3
                Offstage(
                  offstage: offStageTray3!,
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(screenWidth * 0.47,
                              screenHeight * 0.513, screenWidth * 0.495, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              border: Border.fromBorderSide(BorderSide(
                                  color: Color(0xFF11ffFF),
                                  style: BorderStyle.solid,
                                  width: 5))),
                          child: Offstage(
                              offstage: servedItem3!,
                              child: Text(
                                '$table3 번',
                                style: buttonFont,
                              ))),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            screenWidth * 0.5,
                            screenHeight * 0.513,
                            screenWidth * 0.35,
                            screenHeight * 0.389),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFffB7),
                                style: BorderStyle.solid,
                                width: 5))),
                      ),
                      Offstage(
                        offstage: servedItem3!,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              screenWidth * 0.5,
                              screenHeight * 0.515,
                              screenWidth * 0.35,
                              screenHeight * 0.389),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    _servingProvider.itemImageList![2]),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(screenWidth * 0.4,
                            screenHeight * 0.49, screenWidth * 0.25, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFB7B7),
                                style: BorderStyle.solid,
                                width: 10))),
                        child: TextButton(
                            onPressed: () {
                              if (_servingProvider.tray3 == true &&
                                  tableNumber != table3) {
                                showPopup(context, 3);
                              } else if (_servingProvider.tray3 == true &&
                                  tableNumber == table3) {
                                _servingProvider.clearTray3();
                                setState(() {});
                              } else {
                                _servingProvider.setTray3();
                                setState(() {
                                  _servingProvider.itemImageList![2] =
                                      itemImagesList[2][itemNumber];
                                  _servingProvider.servedItemTray3();
                                });
                              }
                            },
                            child: Container(),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(
                                    textButtonWidth, textButtonHeight * 1.3),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 10)))),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
