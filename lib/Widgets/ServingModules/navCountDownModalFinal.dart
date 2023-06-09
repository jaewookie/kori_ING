import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorPauseModuleFinal.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorProgressModuleFinal.dart';
import 'package:provider/provider.dart';

class NavCountDownModalFinal extends StatefulWidget {
  const NavCountDownModalFinal({Key? key}) : super(key: key);

  @override
  State<NavCountDownModalFinal> createState() => _NavCountDownModalFinalState();
}

class _NavCountDownModalFinalState extends State<NavCountDownModalFinal> {
  late ServingModel _servingProvider;
  late NetworkModel _networkProvider;

  late String countDownPopup;

  @override
  Widget build(BuildContext context) {
    _servingProvider = Provider.of<ServingModel>(context, listen: false);
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if(_networkProvider.serviceState==0){
      countDownPopup = 'final_assets/screens/Shipping/koriZFinalShipCountdown.png';
    }else if(_networkProvider.serviceState==1){
      countDownPopup = 'final_assets/screens/Serving/koriZFinalServCountDown.png';
    }

    return Container(
      child:AlertDialog(
        content: Stack(
          children: [Container(
            width: screenWidth * 0.5,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(countDownPopup), fit: BoxFit.fill)),
            child: null,
          ),
            Positioned(
              left: 0,
              top: 192,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius:
                        BorderRadius.circular(0)),
                    fixedSize: Size(362*0.75, 128*0.75)),
                onPressed: (){
                  if(_networkProvider.serviceState==0){
                    Navigator.pop(context);
                  }else if(_networkProvider.serviceState==1){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: null,
              ),
            ),
            Positioned(
              left: 362*0.75,
              top: 192,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius:
                        BorderRadius.circular(0)),
                    fixedSize: Size(362*0.75, 128*0.75)),
                onPressed: (){
                  _servingProvider.playAd = false;
                  navPage(context: context, page: NavigatorProgressModuleFinal(), enablePop: false).navPageToPage();
                },
                child: null,
              ),
            ),
          ]
        ),
        backgroundColor: Colors.transparent,
        contentTextStyle: Theme.of(context).textTheme.headlineLarge,
        // actionsPadding: EdgeInsets.only(top: screenHeight * 0.001),
      )
    );
  }
}
