import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Widgets/OrderedMenuButtons.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelect.dart';
import 'package:kori_test_refactoring/Widgets/ServingModules/tableSelectFinal.dart';
import 'package:kori_test_refactoring/screens/modules/ServingModuleButtonsFinal.dart';
import 'package:provider/provider.dart';

import '../../Providers/ServingModel.dart';
import 'showCheckingModal.dart';

class TrayStatusModalFinal extends StatefulWidget {
  const TrayStatusModalFinal({Key? key})
      : super(key: key);

  @override
  State<TrayStatusModalFinal> createState() => _TrayStatusModalFinalState();
}

class _TrayStatusModalFinalState extends State<TrayStatusModalFinal> {

  late ServingModel _servingProvider;
  String trayStatusImg = 'final_assets/screens/koriZFinalTrayStatus.png';


  @override
  Widget build(BuildContext context) {
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineMedium;

    return Container(
      child: Dialog(
        backgroundColor: Color(0xff000000),
        child: Stack(
            children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(trayStatusImg), fit: BoxFit.cover),
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
              ServingModuleButtonsFinal(screens: 4,),
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
        ]),
      ),
    );
  }
}


