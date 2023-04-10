import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorPauseModuleFinal.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/TrayStatusModalFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving_final/TraySelectionFinal.dart';
import 'package:provider/provider.dart';

class NavCountDownModalFinal extends StatefulWidget {
  const NavCountDownModalFinal({Key? key}) : super(key: key);

  @override
  State<NavCountDownModalFinal> createState() => _NavCountDownModalFinalState();
}

class _NavCountDownModalFinalState extends State<NavCountDownModalFinal> {

  String itemSelectBG = 'final_assets/screens/koriZFinalCountDown.png';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child:AlertDialog(
        content: Stack(
          children: [Container(
            width: screenWidth * 0.5,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(itemSelectBG), fit: BoxFit.fill)),
            child: null,
          ),
            Positioned(
              left: 0,
              top: 192,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius:
                        BorderRadius.circular(0)),
                    fixedSize: Size(362*0.75, 128*0.75)),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
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
                        side: BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius:
                        BorderRadius.circular(0)),
                    fixedSize: Size(362*0.75, 128*0.75)),
                onPressed: (){
                  navPage(context: context, page: NavigatorPauseModuleFinal(), enablePop: false).navPageToPage();
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
