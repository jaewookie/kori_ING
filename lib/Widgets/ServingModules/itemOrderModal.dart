import 'package:flutter/material.dart';
// import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectModal.dart';
import 'package:provider/provider.dart';

import '../../Providers/ServingModel.dart';

class ItemOrderModal extends StatefulWidget {
  const ItemOrderModal({Key? key}) : super(key: key);

  @override
  State<ItemOrderModal> createState() => _ItemOrderModalState();
}

class _ItemOrderModalState extends State<ItemOrderModal> {
  late ServingModel _servingProvider;

  String? tableNumber;

  List<String> orderedItems = [];

  List<String> menuItems = ['햄버거', '라면', '치킨', '핫도그'];
  int? menuLength;

  List<bool>? selectedItem;
  int? selectedQt;

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
          return SelectTableModal();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuImgItems = [hamburgerImg, ramyeonImg, chickenImg, hotDogImg];
    menuLength = menuItems.length;
    selectedItem = List<bool>.filled(menuLength!, true, growable: true);
    // selectedQt = 0;
  }

  @override
  Widget build(BuildContext context) {
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    tableNumber = _servingProvider.tableNumber;

    print(menuLength);
    print(menuLength.runtimeType);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.4;
    double textButtonHeight = screenHeight * 0.15;

    TextStyle? tableFont = Theme.of(context).textTheme.displaySmall;
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
                                              if (selectedItem![
                                              (2 * j)] ==
                                                  true) {
                                                orderedItems.add(
                                                    menuItems[(2 * j)]);
                                                selectedItem!.replaceRange(
                                                    (2 * j),
                                                    (2 * j) + 1,
                                                    [false]);
                                              } else {
                                                orderedItems.remove(
                                                    menuItems[(2 * j)]);
                                                selectedItem!.replaceRange(
                                                    (2 * j) ,
                                                    (2 * j) + 1,
                                                    [true]);
                                              }
                                              selectedQt = 0;
                                              for(int i = 0; i<selectedItem!.length; i++){
                                                if(selectedItem![i]==false){
                                                  setState(() {
                                                    selectedQt=selectedQt!+1;
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
                                                    height:
                                                    screenHeight * 0.2,
                                                    width: screenWidth * 0.4,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                menuImgItems[
                                                                (2 * j)]),
                                                            fit: BoxFit
                                                                .fitHeight))),
                                                Offstage(
                                                  offstage: selectedItem![
                                                  (2 * j)],
                                                  child: Container(
                                                    padding: EdgeInsets.fromLTRB(screenWidth*0.02, screenHeight*0.01, 0, 0),
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
                                                  orderedItems.add(
                                                      menuItems[(2 * j) + 1]);
                                                  selectedItem!.replaceRange(
                                                      (2 * j) + 1,
                                                      (2 * j) + 2,
                                                      [false]);
                                                } else {
                                                  orderedItems.remove(
                                                      menuItems[(2 * j) + 1]);
                                                  selectedItem!.replaceRange(
                                                      (2 * j) + 1,
                                                      (2 * j) + 2,
                                                      [true]);
                                                }
                                              });
                                              selectedQt = 0;
                                              for(int i = 0; i<selectedItem!.length; i++){
                                                if(selectedItem![i]==false){
                                                  setState(() {
                                                    selectedQt=selectedQt!+1;
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
                                                      padding: EdgeInsets.fromLTRB(screenWidth*0.02, screenHeight*0.01, 0, 0),
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
                  textButtonHeight * 0.1, screenWidth * 0.01, 0),
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuButtons(
                        assetsBool: false,
                        onPressed: () {},
                        buttonText: '장바구니',
                        appIcon: Icons.shopping_bag,
                        buttonIconSize: 120,
                        buttonWidth: textButtonWidth,
                        buttonHeight: textButtonHeight * 0.8,
                        buttonColor: const Color.fromRGBO(45, 45, 45, 45),
                        buttonFont: tableFont),
                    MenuButtons(
                        assetsBool: false,
                        onPressed: () {},
                        buttonText: '결제',
                        appIcon: Icons.payment,
                        buttonIconSize: 120,
                        buttonWidth: textButtonWidth,
                        buttonHeight: textButtonHeight * 0.8,
                        buttonColor: const Color.fromRGBO(45, 45, 45, 45),
                        buttonFont: tableFont),
                  ],
                ),
                Container(
                  // color: Colors.red,
                  margin: EdgeInsets.fromLTRB(
                      screenWidth * 0.14, screenWidth * 0.07, 0, 0),
                  width: screenWidth * 0.04,
                  height: screenWidth * 0.04,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                      child: Text(
                        '$selectedQt',
                    style: TextStyle(color: Colors.black),
                  )),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
