import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';

class NFCModuleScreen extends StatefulWidget {
  const NFCModuleScreen({Key? key}) : super(key: key);

  @override
  State<NFCModuleScreen> createState() => _NFCModuleScreenState();
}

class _NFCModuleScreenState extends State<NFCModuleScreen> {

  String NFCimg = 'assets/images/payment_with_NFC.png';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
              Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_sharp),
                      color: const Color(0xffF0F0F0),
                      iconSize: 60,
                    ),
                    IconButton(
                      onPressed: () {
                        navPage(
                            context: context,
                            page: TraySelection3(),
                            enablePop: false)
                            .navPageToPage();
                      },
                      icon: Icon(Icons.cancel_presentation_outlined),
                      color: const Color(0xffF0F0F0),
                      iconSize: 60,
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0,
                        screenHeight * 0.08, 0, 0),
                    // width: screenWidth,
                    height: screenHeight * 0.65,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(NFCimg)),
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
