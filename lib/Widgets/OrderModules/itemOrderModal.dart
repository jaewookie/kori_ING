import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/OrderModel.dart';

import 'package:kori_test_refactoring/Widgets/OrderModules/CheckOutModal.dart';
import 'package:provider/provider.dart';

import '../../Providers/ServingModel.dart';

class ItemOrderModal extends StatefulWidget {
  const ItemOrderModal({Key? key}) : super(key: key);

  @override
  State<ItemOrderModal> createState() => _ItemOrderModalState();
}

class _ItemOrderModalState extends State<ItemOrderModal> {
  late ServingModel _servingProvider;
  late OrderModel _orderProvider;

  String? tableNumber;

  List<String>? orderedItems;

  List<String> menuItems = ['햄버거', '라면', '치킨', '핫도그'];
  int? menuLength;

  List<bool>? selectedItem;
  int? selectedQt;

  bool? checkOutItems;

  String hamburgerImg = 'assets/images/serving_menu_img/menu_hamburger.png';
  String ramyeonImg = 'assets/images/serving_menu_img/menu_ramyeon.png';
  String chickenImg = 'assets/images/serving_menu_img/menu_chicken.png';
  String hotDogImg = 'assets/images/serving_menu_img/menu_hotDog.png';

  late List<String> menuImgItems;

  // 배경 화면
  late String backgroundImage;

  // 상품 구분 번호
  // late int itemNumber;
  int itemNumber = 0;

  void showCheckingPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CheckOutScreen();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuImgItems = [hamburgerImg, ramyeonImg, chickenImg, hotDogImg];
    menuLength = menuItems.length;
    selectedItem = List<bool>.filled(menuLength!, true, growable: true);
    selectedQt = 0;
    checkOutItems = true;
  }

  @override
  Widget build(BuildContext context) {
    _servingProvider = Provider.of<ServingModel>(context, listen: false);
    _orderProvider = Provider.of<OrderModel>(context, listen: false);

    tableNumber = _servingProvider.tableNumber;

    if (_orderProvider.orderedItems == null) {
      orderedItems!.isEmpty;
    } else {
      orderedItems = _orderProvider.orderedItems;
    }

    if (selectedQt == 0) {
      checkOutItems = true;
    } else {
      checkOutItems = false;
    }

    print('asdfsadf');
    print(_orderProvider.orderedItems);
    print('asdfsadf');

    print(menuLength);
    print(menuLength.runtimeType);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.4;
    double textButtonHeight = screenHeight * 0.15;

    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineLarge;

    print(selectedItem);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _orderProvider.orderedItems = [];
                        });
                      },
                      icon: Icon(Icons.cancel_presentation_outlined),
                      color: const Color(0xffF0F0F0),
                      iconSize: 60,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, screenHeight * 0.04, 0, screenHeight * 0.05),
                  width: screenWidth,
                  height: screenHeight * 0.5,
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1))),
                                          onPressed: () {
                                            setState(() {
                                              if (selectedItem![(2 * j)] ==
                                                  true) {
                                                _orderProvider.orderedItems!
                                                    .add(menuItems[(2 * j)]);
                                                selectedItem!.replaceRange(
                                                    (2 * j),
                                                    (2 * j) + 1,
                                                    [false]);
                                              } else {
                                                _orderProvider.orderedItems!
                                                    .remove(menuItems[(2 * j)]);
                                                selectedItem!.replaceRange(
                                                    (2 * j),
                                                    (2 * j) + 1,
                                                    [true]);
                                              }
                                              selectedQt = 0;
                                              for (int i = 0;
                                                  i < selectedItem!.length;
                                                  i++) {
                                                if (selectedItem![i] == false) {
                                                  setState(() {
                                                    selectedQt =
                                                        selectedQt! + 1;
                                                  });
                                                }
                                              }
                                            });
                                            print('담은 상품 : $orderedItems');
                                            print('담은 상품 갯수 : $selectedQt');
                                          },
                                          child: Column(
                                            children: [
                                              Stack(children: [
                                                Container(
                                                    height: screenHeight * 0.2,
                                                    width: screenWidth * 0.4,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                menuImgItems[
                                                                    (2 * j)]),
                                                            fit: BoxFit
                                                                .fitHeight))),
                                                Offstage(
                                                  offstage:
                                                      selectedItem![(2 * j)],
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            screenWidth * 0.02,
                                                            screenHeight * 0.01,
                                                            0,
                                                            0),
                                                    child: Icon(
                                                      Icons
                                                          .check_circle_outline_rounded,
                                                      size: 150,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ]),
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
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.white,
                                                        width: 1))),
                                            onPressed: () {
                                              setState(() {
                                                if (selectedItem![
                                                        (2 * j) + 1] ==
                                                    true) {
                                                  _orderProvider.orderedItems!
                                                      .add(menuItems[
                                                          (2 * j) + 1]);
                                                  selectedItem!.replaceRange(
                                                      (2 * j) + 1,
                                                      (2 * j) + 2,
                                                      [false]);
                                                } else {
                                                  _orderProvider.orderedItems!
                                                      .remove(menuItems[
                                                          (2 * j) + 1]);
                                                  selectedItem!.replaceRange(
                                                      (2 * j) + 1,
                                                      (2 * j) + 2,
                                                      [true]);
                                                }
                                              });
                                              selectedQt = 0;
                                              for (int i = 0;
                                                  i < selectedItem!.length;
                                                  i++) {
                                                if (selectedItem![i] == false) {
                                                  setState(() {
                                                    selectedQt =
                                                        selectedQt! + 1;
                                                  });
                                                }
                                              }
                                              print('담은 상품 : $orderedItems');
                                            },
                                            child: Column(
                                              children: [
                                                Stack(children: [
                                                  Container(
                                                      height:
                                                          screenHeight * 0.2,
                                                      width: screenWidth * 0.4,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  menuImgItems[
                                                                      (2 * j) +
                                                                          1]),
                                                              fit: BoxFit
                                                                  .fitHeight))),
                                                  Offstage(
                                                    offstage: selectedItem![
                                                        (2 * j) + 1],
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              screenWidth *
                                                                  0.02,
                                                              screenHeight *
                                                                  0.01,
                                                              0,
                                                              0),
                                                      child: Icon(
                                                        Icons
                                                            .check_circle_outline_rounded,
                                                        size: 150,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
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
                                        : Container(),
                                  ],
                                ),
                            ],
                          );
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '상품 주문 화면',
                      style: TextStyle(
                          fontSize: 80,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(screenWidth * 0.01,
                  0, screenWidth * 0.01, 0),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(right: screenWidth*0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 300,
                            color: Color(0xffB7B7B7),
                          ),
                          SizedBox(
                            height: screenHeight*0.02,
                          )
                        ],
                      ),
                      SizedBox(
                        width: screenWidth*0.05,
                      ),
                      TextButton(
                          onPressed: () {
                            showCheckingPopup(context);
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // SizedBox(
                                //   width: textButtonWidth * 0.2,
                                // ),
                                Text(
                                  '다음',
                                  style: TextStyle(
                                    fontFamily: 'kor',
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffB7B7B7)
                                  ),
                                ),
                                Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xffB7B7B7),
                                    size: 110,
                                  ),
                              ],
                            ),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(45, 45, 45, 45),
                              // backgroundColor: Color(0xFF2D2D2D),
                              fixedSize:
                                  Size(textButtonWidth*1.3, textButtonHeight * 0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))))
                    ],
                  ),
                ),
                Offstage(
                  offstage: checkOutItems!,
                  child: Container(
                    // color: Colors.red,
                    margin: EdgeInsets.fromLTRB(
                        screenWidth * 0.14, screenWidth * 0.075, 0, 0),
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.05,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 30),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      '$selectedQt',
                      style: TextStyle(fontFamily: 'kor', color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
