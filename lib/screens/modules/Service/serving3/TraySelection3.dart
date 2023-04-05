import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/itemOrderModal.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/itemSelectModal.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/receiptModal.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectModal.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:provider/provider.dart';


// 트레이 반응형 UI

class TraySelection3 extends StatefulWidget {
  const TraySelection3({Key? key}) : super(key: key);

  @override
  State<TraySelection3> createState() => _TraySelection3State();
}

class _TraySelection3State extends State<TraySelection3> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    backgroundImage = "assets/images/KoriBackgroundImage_v1.png";
    koriBody = "assets/images/serving_img/kori_body.png";
  }

  void showReceiptSelectPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          if (receiptModeOn == true) {
            return SelectReceiptModal();
          } else {
            return SelectItemModal();
          }
        });
  }

  void showTableSelectPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SelectTableModal();
        });
  }

  void showOrderPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ItemOrderModal();
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

    receiptModeOn = _servingProvider.receiptModeOn!;

    table1 = _servingProvider.table1;
    table2 = _servingProvider.table2;
    table3 = _servingProvider.table3;

    item1 = _servingProvider.item1;
    item2 = _servingProvider.item2;
    item3 = _servingProvider.item3;

    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;

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
    print(itemNumber);
    print(tableNumber);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.6;
    double textButtonHeight = screenHeight * 0.08;
    
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
            navPage(context: context, page: ServiceScreen(), enablePop: false)
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
              _servingProvider.clearAllTray();
              _servingProvider.initServing();
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
            //기능적 부분
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(koriBody)),
              ),
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Stack(children: [
                // 상단 문구 및 현재 선택 상품, 테이블 번호 표시
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            showOrderPopup(context);
                          },
                          child: Text('주문 하기', style: textFont2),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              fixedSize:
                                  Size(textButtonWidth * 0.5, textButtonHeight),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFB7B7B7),
                                      style: BorderStyle.solid,
                                      width: 10)))),
                      SizedBox(
                        width: screenWidth * 0.15,
                      ),
                      TextButton(
                          onPressed: () {
                            _servingProvider.trayCheckAll = true;
                            // _servingProvider.servingBeginningIsNot=true;
                            showTableSelectPopup(context);
                            _servingProvider.menuItem = "상품";
                          },
                          child: Text('서빙 시작', style: textFont2),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              fixedSize:
                                  Size(textButtonWidth * 0.5, textButtonHeight),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFB7B7B7),
                                      style: BorderStyle.solid,
                                      width: 10)))),
                    ],
                  ),
                ),
                // 디버그 버튼
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 디버그 버튼 트레이 활성화용
                    Offstage(
                      offstage: _debugTray,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  if (receiptModeOn == true) {
                                    _servingProvider.receiptModeOn = false;
                                  } else {
                                    _servingProvider.receiptModeOn = true;
                                  }
                                });
                              },
                              child: _servingProvider.receiptModeOn == true
                                  ? Text(
                                      'Receipt Mode',
                                      style: buttonFont,
                                    )
                                  : Text('Normal Mode', style: buttonFont),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  fixedSize: Size(textButtonWidth * 0.25,
                                      textButtonHeight * 0.5),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFB7B7B7),
                                          style: BorderStyle.solid,
                                          width: 10)))),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.5,
                    ),
                  ],
                ),
                // 초기화 버튼
                Container(
                  padding: EdgeInsets.fromLTRB(screenWidth*0.05, screenHeight*0.25, 0, 0),
                  child: Column(
                    children: [
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
                ),
                //트레이1
                Offstage(
                  offstage: offStageTray1!,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(screenWidth * 0.45,
                            screenHeight * 0.290, screenWidth * 0.495, 0),
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
                            screenHeight * 0.290,
                            screenWidth * 0.35,
                            screenHeight * 0.613),
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
                                screenHeight * 0.290,
                                screenWidth * 0.35,
                                screenHeight * 0.613),
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
                            screenHeight * 0.27,
                            screenWidth * 0.25,
                            screenHeight * 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFB7B7),
                                style: BorderStyle.solid,
                                width: 10))),
                        child: TextButton(
                            onPressed: () {
                              print("tapped");
                              _servingProvider.tray1Select = true;
                              _servingProvider.trayCheckAll = false;
                              showReceiptSelectPopup(context);
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
                        margin: EdgeInsets.fromLTRB(screenWidth * 0.450,
                            screenHeight * 0.405, screenWidth * 0.495, 0),
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
                            screenHeight * 0.405,
                            screenWidth * 0.35,
                            screenHeight * 0.497),
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
                              screenHeight * 0.405,
                              screenWidth * 0.35,
                              screenHeight * 0.497),
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
                            screenHeight * 0.385, screenWidth * 0.25, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFB7B7),
                                style: BorderStyle.solid,
                                width: 10))),
                        child: TextButton(
                            onPressed: () {
                              _servingProvider.tray2Select = true;
                              _servingProvider.trayCheckAll = false;
                              showReceiptSelectPopup(context);
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
                          margin: EdgeInsets.fromLTRB(screenWidth * 0.45,
                              screenHeight * 0.535, screenWidth * 0.495, 0),
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
                            screenHeight * 0.535,
                            screenWidth * 0.35,
                            screenHeight * 0.367),
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
                              screenHeight * 0.535,
                              screenWidth * 0.35,
                              screenHeight * 0.367),
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
                            screenHeight * 0.512, screenWidth * 0.25, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFFFFB7B7),
                                style: BorderStyle.solid,
                                width: 10))),
                        child: TextButton(
                            onPressed: () {
                              _servingProvider.tray3Select = true;
                              _servingProvider.trayCheckAll = false;
                              showReceiptSelectPopup(context);
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
