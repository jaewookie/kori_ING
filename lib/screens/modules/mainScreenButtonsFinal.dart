import 'package:flutter/material.dart';
// import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
// import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/itemOrderModal.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectModal.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectModalFinal.dart';

import 'package:kori_test_refactoring/screens/AdminScreen.dart';
import 'package:kori_test_refactoring/screens/ConfigScreen.dart';
import 'package:kori_test_refactoring/screens/LinkConnectorScreen.dart';
import 'package:kori_test_refactoring/screens/ServiceScreenFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/hotel/HotelServiceMenu.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving_final/TraySelectionFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingMenu.dart';
import 'package:provider/provider.dart';

class FinalMainScreenButtons extends StatefulWidget {
  final int? screens;

  const FinalMainScreenButtons({
    Key? key,
    this.screens,
  }) : super(key: key);

  @override
  State<FinalMainScreenButtons> createState() => _FinalMainScreenButtonsState();
}

class _FinalMainScreenButtonsState extends State<FinalMainScreenButtons> {
  // late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  late var screenList = List<Widget>.empty();
  late var serviceList = List<Widget>.empty();

  late var homeButtonName = List<String>.empty();

  double pixelRatio = 0.75;

  late List<double> buttonPositionWidth;
  late List<double> buttonPositionHeight;
  late List<double> buttonSize;

  late double buttonRadius;

  late List<double> buttonSize1;
  late List<double> buttonSize2;

  late int buttonNumbers;

  int buttonWidth = 0;
  int buttonHeight = 1;

  List<String> menuItems = ['햄버거', '라면', '치킨', '핫도그'];

  String? table1;
  String? table2;
  String? table3;
  String? tableAll;

  String? item1;
  String? item2;
  String? item3;

  int itemNumber = 0;
  String? itemName;

  late String hamburger;
  late String hotDog;
  late String chicken;
  late String ramyeon;

  late List<List> itemImagesList;
  late List<String> itemImages;

  String? startUrl;
  String? navUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // poseDataUpdate(widget.parsePoseData);

    homeButtonName = ["택배", "서빙", "호텔"];

    hamburger = "assets/images/serving_item_imgs/hamburger.png";
    hotDog = "assets/images/serving_item_imgs/hotDog.png";
    chicken = "assets/images/serving_item_imgs/chicken.png";
    ramyeon = "assets/images/serving_item_imgs/ramyeon.png";

    itemImages = [hamburger, hotDog, chicken, ramyeon];
    itemImagesList = [itemImages, itemImages, itemImages];

    screenList = [
      const ServiceScreenFinal(),
      const LinkConnectorScreen(),
      const AdminScreen(),
      const ConfigScreen()
    ];
    serviceList = [ShippingMenu(), TraySelectionFinal(), HotelServiceMenu()];
  }

  void showOrderPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ItemOrderModal();
        });
  }

  void showTableSelectPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SelectTableModalFinal();
        });
  }

  void uploadTableNumberNItemImg() {
    if (_servingProvider.tray1Select == true) {
      _servingProvider.setTray1();
      setState(() {
        _servingProvider.itemImageList![0] = itemImagesList[0][itemNumber];
        _servingProvider.servedItem1 = false;
      });
    } else if (_servingProvider.tray2Select == true) {
      _servingProvider.setTray1();
      setState(() {
        _servingProvider.itemImageList![1] = itemImagesList[1][itemNumber];
        _servingProvider.servedItem2 = false;
      });
    } else if (_servingProvider.tray3Select == true) {
      _servingProvider.setTray1();
      setState(() {
        _servingProvider.itemImageList![2] = itemImagesList[2][itemNumber];
        _servingProvider.servedItem3 = false;
      });
    }
  }

  void showCheckingStartServing(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          // _networkProvider = Provider.of<NetworkModel>(context, listen: false);
          _servingProvider = Provider.of<ServingModel>(context, listen: false);

          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          table1 = _servingProvider.table1;
          table2 = _servingProvider.table2;
          table3 = _servingProvider.table3;

          item1 = _servingProvider.item1;
          item2 = _servingProvider.item2;
          item3 = _servingProvider.item3;

          // startUrl = _networkProvider.startUrl;
          // navUrl = _networkProvider.navUrl;

          tableAll = _servingProvider.tableNumber;

          return AlertDialog(
            content: SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('다른 트레이에 상품을 추가하시겠습니까?'),
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
                children: [
                  TextButton(
                    onPressed: () {
                      _servingProvider.cancelTraySelection();
                      navPage(
                          context: context,
                          page: TraySelectionFinal(),
                          enablePop: false)
                          .navPageToPage();
                    },
                    child: Text(
                      '상품 추가하기',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    style: TextButton.styleFrom(
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
                      showCountDownStarting(context);
                    },
                    child: Text('서빙 시작하기',
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

  void showCountDownStarting(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          // _networkProvider = Provider.of<NetworkModel>(context, listen: false);
          _servingProvider = Provider.of<ServingModel>(context, listen: false);

          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          table1 = _servingProvider.table1;
          table2 = _servingProvider.table2;
          table3 = _servingProvider.table3;

          item1 = _servingProvider.item1;
          item2 = _servingProvider.item2;
          item3 = _servingProvider.item3;

          List<String> tableDestinations = [];
          List<String> itemDestinations = [];
          List<String> trayDestinations = [];

          // startUrl = _networkProvider.startUrl;
          // navUrl = _networkProvider.navUrl;

          tableAll = _servingProvider.tableNumber;

          return AlertDialog(
            content: SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('5초 후 서빙을 시작합니다.'),
                  Text('즉시 시작하려면 하단의 버튼을 눌러주세요'),
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
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    style: TextButton.styleFrom(
                        shape: LinearBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            top: LinearBorderEdge(size: 0.9),
                            end: LinearBorderEdge(size: 0.9)),
                        minimumSize:
                        Size(screenWidth * 0.27, screenHeight * 0.04)),
                  ),
                  TextButton(
                    onPressed: () {
                      _servingProvider.playAd = false;

                      if (_servingProvider.trayCheckAll == false) {
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
                      } else {
                        tableDestinations.add(_servingProvider.tableNumber!);
                        itemDestinations.add(item3!);
                        trayDestinations.add('all');
                      }
                      _servingProvider.tableList = tableDestinations;
                      _servingProvider.itemList = itemDestinations;
                      _servingProvider.trayList = trayDestinations;

                      // PostApi(
                      //     url: startUrl,
                      //     endadr: navUrl,
                      //     keyBody:
                      //     'serving_${tableDestinations[0].toString()}')
                      //     .Posting();
                      // _networkProvider.currentGoal =
                      // '${tableDestinations[0].toString()}번 테이블';

                      navPage(
                          context: context,
                          page: NavigatorModule(),
                          enablePop: true)
                          .navPageToPage();
                    },
                    child: Text('즉시 시작',
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
  Widget build(BuildContext context) {
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    itemName = _servingProvider.menuItem;

    if (widget.screens == 0) {
      // 메인 화면
      buttonPositionWidth = [121, 747, 121, 747];
      buttonPositionHeight = [400, 400, 1021, 1021];

      buttonSize = [570, 565];

      buttonRadius = 30;
    } else if (widget.screens == 1) {
      // 서비스 선택화면
      buttonPositionWidth = [121, 121, 121];
      buttonPositionHeight = [400, 723, 1046];

      buttonSize = [1198, 256];

      buttonRadius = 30;
    } else if (widget.screens == 2) {
      // 서빙화면(주문하기 및 서빙시작)
      buttonPositionWidth = [109, 757];
      buttonPositionHeight = [225, 225];

      buttonSize = [570, 220];

      buttonRadius = 30;
    } else if (widget.screens == 3) {
      // 서빙 상품 선택 화면
      buttonPositionWidth = [100, 688, 100, 688];
      buttonPositionHeight = [600, 600, 1180, 1180];

      buttonSize = [545, 545];

      buttonRadius = 30;
    } else if (widget.screens == 4) {
      // 서빙 테이블 선택 화면
      buttonPositionWidth = [254, 254, 254, 254, 788, 788, 788, 788];
      buttonPositionHeight = [515, 964, 1390, 1822, 515, 964, 1390, 1822];

      buttonSize = [292, 167];

      buttonRadius = 0;
    } else if (widget.screens == 5) {
      // 서빙 테이블 선택 화면
      buttonPositionWidth = [70, 70, 70, 70, 688, 688, 688, 688];
      buttonPositionHeight = [444, 872, 1300, 1728, 444, 872, 1300, 1728];

      buttonSize = [570, 378];

      buttonRadius = 50;
    }

    buttonNumbers = buttonPositionHeight.length;

    if (_servingProvider.trayCheckAll == false) {
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
    }

    return Stack(children: [
      for (int i = 0; i < buttonNumbers; i++)
        Positioned(
          left: buttonPositionWidth[i] * pixelRatio,
          top: buttonPositionHeight[i] * pixelRatio,
          child: FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(buttonRadius * pixelRatio)),
                fixedSize: Size(buttonSize[buttonWidth] * pixelRatio,
                    buttonSize[buttonHeight] * pixelRatio)),
            onPressed: () {
              if (widget.screens == 0) {
                navPage(context: context, page: screenList[i], enablePop: true)
                    .navPageToPage();
                // _networkProvider.serviceState = i;
              } else if (widget.screens == 1) {
                if (i == 0) {
                  navPage(
                          context: context,
                          page: serviceList[i],
                          enablePop: true)
                      .navPageToPage();
                } else if (i == 1) {
                  navPage(
                          context: context,
                          page: serviceList[i],
                          enablePop: true)
                      .navPageToPage();
                } else {
                  navPage(
                          context: context,
                          page: serviceList[i],
                          enablePop: true)
                      .navPageToPage();
                }
              } else if (widget.screens == 2) {
                if (i == 0) {
                  showOrderPopup(context);
                } else {
                  _servingProvider.trayCheckAll = true;
                  // _servingProvider.servingBeginningIsNot=true;
                  showTableSelectPopup(context);
                  _servingProvider.menuItem = "상품";
                }
              } else if (widget.screens == 3) {
                setState(() {
                  if (i == 0) {
                    _servingProvider.menuItem = menuItems[i];
                  } else if (i == 1) {
                    _servingProvider.menuItem = menuItems[i];
                  } else if (i == 2) {
                    _servingProvider.menuItem = menuItems[i];
                  } else {
                    _servingProvider.menuItem = menuItems[i];
                  }
                });
                if (_servingProvider.tray1Select == true) {
                  _servingProvider.setItemTray1();
                } else if (_servingProvider.tray2Select == true) {
                  _servingProvider.setItemTray2();
                } else if (_servingProvider.tray3Select == true) {
                  _servingProvider.setItemTray3();
                }
                Navigator.pop(context);
                showTableSelectPopup(context);
              }else if(widget.screens == 4){
                print(_servingProvider.trayCheckAll);
                setState(() {
                  _servingProvider.tableNumber = "${i+1}";
                  if (_servingProvider.trayCheckAll == false) {
                    if (_servingProvider.tray1Select == true) {
                      _servingProvider.table1 = "${i+1}";
                    } else if (_servingProvider.tray2Select == true) {
                      _servingProvider.table2 = "${i+1}";
                    } else if (_servingProvider.tray3Select == true) {
                      _servingProvider.table3 = "${i+1}";
                    }
                  } else {
                    _servingProvider.setTrayAll();
                    _servingProvider.tableNumber = "${i+1}";
                  }
                });
                uploadTableNumberNItemImg();
                showCheckingStartServing(context);
              }
            },
            child: null,
          ),
        ),
    ]);
  }
}
