import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectModalFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving_final/TraySelectionFinal.dart';
import 'package:kori_test_refactoring/screens/modules/ServingModuleButtonsFinal.dart';
import 'package:provider/provider.dart';

import 'tableSelectModal.dart';

class TableSelectImgFinal extends StatefulWidget {
  const TableSelectImgFinal({Key? key}) : super(key: key);

  @override
  State<TableSelectImgFinal> createState() => _TableSelectImgFinalState();
}

class _TableSelectImgFinalState extends State<TableSelectImgFinal> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String tableSelectBG = 'final_assets/screens/Serving/koriZFinalTableSelect.png';

  String? tableNumber;

  String? table1;
  String? table2;
  String? table3;

  String? tableAll;

  String? itemName;

  String? item1;
  String? item2;
  String? item3;

  int itemNumber = 0;

  late String hamburger;
  late String hotDog;
  late String chicken;
  late String ramyeon;

  String? startUrl;
  String? navUrl;

  late List<List> itemImagesList;
  late List<String> itemImages;

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

  void showTableSelectPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SelectTableModalFinal();
        });
  }

  void showCheckingStartServing(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          _networkProvider = Provider.of<NetworkModel>(context, listen: false);
          _servingProvider = Provider.of<ServingModel>(context, listen: false);

          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          table1 = _servingProvider.table1;
          table2 = _servingProvider.table2;
          table3 = _servingProvider.table3;

          item1 = _servingProvider.item1;
          item2 = _servingProvider.item2;
          item3 = _servingProvider.item3;

          startUrl = _networkProvider.startUrl;
          navUrl = _networkProvider.navUrl;

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
          _networkProvider = Provider.of<NetworkModel>(context, listen: false);
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

          startUrl = _networkProvider.startUrl;
          navUrl = _networkProvider.navUrl;

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
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineMedium;

    tableNumber = _servingProvider.tableNumber;
    itemName = _servingProvider.menuItem;

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
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(tableSelectBG), fit: BoxFit.cover),
        ),
      ),
      Positioned(
          left: 1140 * 0.75,
          top: 195 * 0.75,
          child: Container(
            width: 48,
            height: 48,
            color: Colors.transparent,
            child: FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      // side: BorderSide(width: 1, color: Colors.white)
                  )),
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
      ServingModuleButtonsFinal(screens: 2,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '테이블 선택 화면',
            style: TextStyle(
                fontSize: 80, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ]);
  }
}





//      Column(
//         children: [
//           Container(
//             margin: EdgeInsets.fromLTRB(190, 145, 0, 0),
//             height: 102,
//             width: 218,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 print(_servingProvider.trayCheckAll);
//                 setState(() {
//                   _servingProvider.tableNumber = "1";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "1";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "1";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "1";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                     _servingProvider.tableNumber = "1";
//                   }
//                 });
//                 print(_servingProvider.tableNumber);
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '1번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(190, 197, 0, 0),
//             height: 102,
//             width: 218,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   _servingProvider.tableNumber = "2";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "2";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "2";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "2";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                     _servingProvider.tableNumber = "2";
//                   }
//                 });
//                 print(_servingProvider.tableNumber);
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '2번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(190, 205, 0, 0),
//             height: 102,
//             width: 218,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   _servingProvider.tableNumber = "3";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "3";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "3";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "3";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                     _servingProvider.tableNumber = "3";
//                   }
//                 });
//                 print(_servingProvider.tableNumber);
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '3번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(190, 225, 0, 0),
//             height: 102,
//             width: 218,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   _servingProvider.tableNumber = "4";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "4";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "4";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "4";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                   }
//                 });
//                 print(_servingProvider.tableNumber);
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '4번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           )
//         ],
//       ),
//       Column(
//         children: [
//           Container(
//             margin: EdgeInsets.fromLTRB(632, 84, 0, 0),
//             height: 330,
//             width: 137,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   _servingProvider.tableNumber = "5";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "5";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "5";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "5";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                     _servingProvider.tableNumber = "5";
//                   }
//                 });
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '5번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(632, 133, 0, 0),
//             height: 330,
//             width: 137,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   _servingProvider.tableNumber = "6";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "6";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "6";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "6";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                     _servingProvider.tableNumber = "6";
//                   }
//                 });
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '6번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(632, 120, 0, 0),
//             height: 330,
//             width: 137,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 border: Border.fromBorderSide(BorderSide(
//                     color: Color(0xFF11ffFF),
//                     style: BorderStyle.solid,
//                     width: 5))),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   _servingProvider.tableNumber = "7";
//                   if (_servingProvider.trayCheckAll == false) {
//                     if (_servingProvider.tray1Select == true) {
//                       _servingProvider.table1 = "7";
//                     } else if (_servingProvider.tray2Select == true) {
//                       _servingProvider.table2 = "7";
//                     } else if (_servingProvider.tray3Select == true) {
//                       _servingProvider.table3 = "7";
//                     }
//                   } else {
//                     _servingProvider.setTrayAll();
//                     _servingProvider.tableNumber = "7";
//                   }
//                 });
//                 uploadTableNumberNItemImg();
//                 showCheckingStartServing(context);
//               },
//               child: Text(
//                 '7번 테이블',
//                 style: tableButtonFont,
//               ),
//             ),
//           ),
//         ],
//       ),