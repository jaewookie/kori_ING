import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/Widgets/ShippingButtons.dart';
import 'package:kori_test_refactoring/screens/modules/OrderModuleButtonsFinal.dart';
import 'package:kori_test_refactoring/screens/modules/ShippingModuleButtonsFinal.dart';
import 'package:provider/provider.dart';

class ShippingDestinationModalFinal extends StatefulWidget {
  const ShippingDestinationModalFinal({Key? key}) : super(key: key);

  @override
  State<ShippingDestinationModalFinal> createState() =>
      _ShippingDestinationModalFinalState();
}

class _ShippingDestinationModalFinalState extends State<ShippingDestinationModalFinal> {
  late NetworkModel _networkProvider;

  String? startUrl;
  String? navUrl;
  String? chgUrl;
  String? stpUrl;
  String? rsmUrl;

  late var goalPosition = List<String>.empty();

  String itemSelectBG = 'final_assets/screens/Shipping/koriZFinalShippingList.png';

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    goalPosition = _networkProvider.goalPosition;
    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;
    stpUrl = _networkProvider.stpUrl;
    rsmUrl = _networkProvider.rsmUrl;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double textButtonWidth = screenWidth * 0.34; //0.4
    double textButtonHeight = screenHeight * 0.105; //0.7

    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineLarge;

    return Container(
      child: Dialog(
        backgroundColor: Color(0xff000000),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Color(0xFFB7B7B7),
              style: BorderStyle.solid,
              width: 1,
            )),
        child: Container(
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight*0.8,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(itemSelectBG), fit: BoxFit.fill)),
              ),
              Positioned(
                  left: 1189 * 0.75,
                  top: 34 * 0.75,
                  child: Container(
                    width: 55,
                    height: 55,
                    color: Colors.transparent,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            // side: BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(0))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: null,
                    ),
                  )),
              Center(
                child: Text(
                  '배송지 목록 스크린',
                  style: TextStyle(
                      fontSize: 80,
                      color: Color.fromRGBO(200, 80, 0, 200),
                      fontWeight: FontWeight.bold),
                ),
              ),
              ShippingModuleButtonsFinal(screens: 2,)
            ],
          ),
        )
      ),
    );
  }
}
