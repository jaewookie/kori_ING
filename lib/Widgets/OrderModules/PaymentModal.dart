import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Widgets/OrderModules/NFCModal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  String hamburgerImg = 'assets/images/payment_with_NFC.png';

  void showNFCPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return NFCModuleScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    TextStyle? tableFont = Theme.of(context).textTheme.displaySmall;

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed:(){},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text(
                                    '결제 금액',
                                    style: TextStyle(
                                        fontFamily: 'kor',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Color(0xffF0F0F0)),
                                  ),],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '결제 금액(숫자)',
                                      style: TextStyle(
                                          fontFamily: 'kor',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 90,
                                          color: Color(0xffF0F0F0)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(870, 350),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xffF0F0F0),
                                        style: BorderStyle.solid,
                                        width: 5),
                                    borderRadius: BorderRadius.circular(40)))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           TextButton(
                               onPressed:(){},
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [Icon(Icons.money, size: 300, color: Color(0xffF0F0F0),)],
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text(
                                         '현금 결제',
                                         style: tableFont,
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                               style: TextButton.styleFrom(
                                   backgroundColor: Colors.transparent,
                                   fixedSize: Size(400, 500),
                                   shape: RoundedRectangleBorder(
                                       side: BorderSide(
                                           color: Color(0xffF0F0F0),
                                           style: BorderStyle.solid,
                                           width: 5),
                                       borderRadius: BorderRadius.circular(40)))),
                           TextButton(
                               onPressed:(){
                                 showNFCPopup(context);
                               },
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [Icon(Icons.credit_card, size: 300, color: Color(0xffF0F0F0),)],
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text(
                                         '카드 결제',
                                         style: tableFont,
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                               style: TextButton.styleFrom(
                                   backgroundColor: Colors.transparent,
                                   fixedSize: Size(400, 500),
                                   shape: RoundedRectangleBorder(
                                       side: BorderSide(
                                           color: Color(0xffF0F0F0),
                                           style: BorderStyle.solid,
                                           width: 5),
                                       borderRadius: BorderRadius.circular(40))))
                         ],
                        )
                      ],
                    )),
              ]),
            ],
          ),
        ));
  }
}
