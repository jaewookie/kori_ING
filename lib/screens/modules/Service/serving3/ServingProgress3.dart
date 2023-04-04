import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/ServingButtons.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:provider/provider.dart';

class ServingProgress3 extends StatefulWidget {
  const ServingProgress3({Key? key}) : super(key: key);

  @override
  State<ServingProgress3> createState() => _ServingProgress3State();
}

class _ServingProgress3State extends State<ServingProgress3> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  late String itemName;
  late String tableName;
  late String trayName;

  String? startUrl;
  String? navUrl;
  String? chgUrl;

  late List<String> tableDestinations;
  late List<String> itemDestinations;
  late List<String> trayDestinations;

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;

    tableDestinations = _servingProvider.tableList!;
    itemDestinations = _servingProvider.itemList!;
    trayDestinations = _servingProvider.trayList!;

    itemName = itemDestinations[0];
    tableName = tableDestinations[0];
    trayName = trayDestinations[0];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 0.35;
    double buttonHeight = screenHeight * 0.12;

    TextStyle? textFont1 = Theme.of(context).textTheme.displayMedium;
    TextStyle? buttonFont = Theme.of(context).textTheme.displaySmall;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                _servingProvider.initServing();
                _servingProvider.clearAllTray();
                navPage(
                        context: context,
                        page: ServiceScreen(),
                        enablePop: false)
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
            child: Stack(children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(_servingProvider.trayCheckAll == true)
                          Column(
                          children: [
                            Text('주문 하신 ${itemName!} 나왔습니다.', style: textFont1),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            Text('선반에서 상품을 수령 하신 후', style: textFont1),
                            Text('완료 버튼을 눌러주세요.', style: textFont1),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                          ],
                        )
                        else
                          Column(
                            children: [
                              Text('주문 하신 ${itemName!} 나왔습니다.', style: textFont1),
                              SizedBox(
                                height: screenHeight * 0.05,
                              ),
                              Text('$trayName번 선반에서', style: textFont1),
                              Text('상품을 수령 하신 후', style: textFont1),
                              Text('완료 버튼을 눌러주세요.', style: textFont1),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: screenWidth * 0.325,
                top: screenHeight * 0.55,
                child: ServingButtons(
                  onPressed: () {

                    _servingProvider.playAd = false;

                    if (tableDestinations.length > 1) {
                      itemDestinations.removeAt(0);
                      tableDestinations.removeAt(0);
                      trayDestinations.removeAt(0);
                    } else {
                      tableDestinations.clear();
                      itemDestinations.clear();
                      trayDestinations.clear();
                    }
                    _servingProvider.itemList = itemDestinations;
                    _servingProvider.tableList = tableDestinations;
                    _servingProvider.trayList = trayDestinations;
                    print(_servingProvider.itemList);
                    print(_servingProvider.tableList);
                    print(_servingProvider.trayList);

                    if (_servingProvider.tableList!.length == 0) {
                      PostApi(
                              url: startUrl,
                              endadr: chgUrl,
                              keyBody: 'charging_pile')
                          .Posting();
                      _networkProvider.currentGoal = '충전스테이션';
                      _networkProvider.servingDone = true;
                      navPage(
                              context: context,
                              page: NavigatorModule(),
                              enablePop: true)
                          .navPageToPage();
                      _servingProvider.initServing();
                    } else {
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
                    }
                  },
                  buttonWidth: buttonWidth,
                  buttonHeight: buttonHeight,
                  buttonText: '완료',
                  buttonFont: buttonFont,
                  buttonColor: Color.fromRGBO(45, 45, 45, 45),
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              )
            ])));
  }
}
