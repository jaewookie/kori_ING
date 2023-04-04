import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/ServingButtons.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving/ServingMenu.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving/ServingProgress.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:provider/provider.dart';

class ShippingDone extends StatefulWidget {
  const ShippingDone({Key? key}) : super(key: key);

  @override
  State<ShippingDone> createState() => _ShippingDoneState();
}

class _ShippingDoneState extends State<ShippingDone> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? startUrl;
  String? navUrl;
  String? chgUrl;

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    startUrl = _networkProvider.startUrl;
    chgUrl = _networkProvider.chgUrl;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textBoxWidth = screenWidth * 0.8;
    double textBoxHeight = screenHeight * 0.125;

    double buttonWidth = screenWidth * 0.35;
    double buttonHeight = screenHeight * 0.12;

    TextStyle? textFont1 = Theme.of(context).textTheme.displayMedium;
    TextStyle? textFont2 = Theme.of(context).textTheme.displaySmall;
    TextStyle? subTextFont = Theme.of(context).textTheme.headlineLarge;
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
                margin: EdgeInsets.only(top: screenHeight * 0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            // Text('주문 하신 xx 나왔습니다.', style: textFont1),
                            // SizedBox(
                            //   height: screenHeight*0.05,
                            // ),
                            Text('배송이 완료 되었습니다.', style: textFont1),
                            Text('확인 버튼을 눌러주세요.', style: textFont1),
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
                    PostApi(
                            url: startUrl,
                            endadr: chgUrl,
                            keyBody: 'charging_pile')
                        .Posting();
                    _networkProvider.currentGoal = '충전스테이션';
                    navPage(
                            context: context,
                            page: NavigatorModule(),
                            enablePop: true)
                        .navPageToPage();
                    // navPage(context: context, page: ServingMenu(), enablePop: true).navPageToPage();
                    _networkProvider.shippingDone = true;
                  },
                  buttonWidth: buttonWidth,
                  buttonHeight: buttonHeight,
                  buttonText: '확인',
                  buttonFont: buttonFont,
                  buttonColor: Color.fromRGBO(45, 45, 45, 45),
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              )
            ])));
  }
}
