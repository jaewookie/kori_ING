import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/screens/modules/NavModuleButtonsFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving/ServingMenu.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving/ServingProgress.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving2/ServingMenu2.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving2/ServingProgress2.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/ServingProgress3.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving_final/ServingProgressFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingDestinationModule.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingDone.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingMenu.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class NavigatorPauseModuleFinal extends StatefulWidget {
  NavigatorPauseModuleFinal({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigatorPauseModuleFinal> createState() =>
      _NavigatorPauseModuleFinalState();
}

class _NavigatorPauseModuleFinalState extends State<NavigatorPauseModuleFinal> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  late VideoPlayerController _controller;

  String introVideo = 'assets/videos/KoriIntro_v1.1.0.mp4';

  String? startUrl;
  String? stpUrl;
  String? rsmUrl;
  String? navUrl;
  String? chgUrl;

  bool? offStageAd;

  int? shipping;
  int? serving;
  int? bellboy;
  int? roomService;

  String? currentGoal;

  bool? pauseCheck;

  int? serviceState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pauseCheck = false;

    shipping = 0;
    serving = 1;
    bellboy = 2;
    roomService = 3;

    _controller = VideoPlayerController.asset(introVideo)
      ..initialize().then((_) {
        _controller.setLooping(true);
        // setLooping -> true 무한반복 false 1회 재생
        setState(() {});
      });

    _playVideo();
  }

  void _playVideo() async {
    _controller.play();
  }

  String backgroundImage = "final_assets/screens/koriZFinalPauseNav.png";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    offStageAd = _servingProvider.playAd;

    startUrl = _networkProvider.startUrl;
    stpUrl = _networkProvider.stpUrl;
    rsmUrl = _networkProvider.rsmUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;
    currentGoal = _networkProvider.currentGoal;

    serviceState = _networkProvider.serviceState;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double videoWidth = _controller.value.size.width;
    double videoHeight = _controller.value.size.height;

    double textButtonWidth = screenWidth * 0.55;
    double textButtonHeight = screenHeight * 0.15 * 0.6;
    // double textButtonWidth = screenWidth * 0.85;
    // double textButtonHeight = screenHeight * 0.15;

    TextStyle? textFont1 = Theme.of(context).textTheme.displaySmall;
    TextStyle? textFont2 = Theme.of(context).textTheme.headlineLarge;

    TextStyle? buttonFont = Theme.of(context).textTheme.displayLarge;
    TextStyle? buttonFont2 = Theme.of(context).textTheme.displaySmall;

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
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 600, 0),
            child: TextButton(
              onPressed: () {
                navPage(context: context, page: ServingProgressFinal(), enablePop: false).navPageToPage();
              },
              child: Text(
                '도착',
                style: TextStyle(
                    fontFamily: 'kok', fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
              ),
              style: TextButton.styleFrom(
                  fixedSize: Size(100, 0),
                  backgroundColor: Colors.transparent,
                  // shape: RoundedRectangleBorder(
                  //     side: BorderSide(width: 1, color: Colors.white)
                  // )
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            onPressed: () {
              _servingProvider.clearAllTray();
              _servingProvider.initServing();
              navPage(context: context, page: ServiceScreen(), enablePop: false)
                  .navPageToPage();
            },
            icon: Icon(
              Icons.home_outlined,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.03,
            alignment: Alignment.center,
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            onPressed: () {
              setState(() {
                _servingProvider.playAD();
              });
            },
            icon: Icon(
              Icons.play_circle,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.03,
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Icon(Icons.battery_charging_full,
                color: Colors.teal, size: screenHeight * 0.03),
          ),
        ],
        toolbarHeight: screenHeight * 0.045,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundImage), fit: BoxFit.cover)),
          child: Container(
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.04),
                    child: null),
                NavModuleButtonsFinal(
                  screens: 1,
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          // 스크린 터치시 화면 이동을 위한 위젯
          onTap: () {
            setState(() {
              _servingProvider.playAD();
            });
          },
          child: Center(
            child: Offstage(
              offstage: offStageAd!,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth,
                          height: screenHeight * 0.8,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: videoWidth,
                              height: videoHeight,
                              child: _controller.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(
                                        _controller,
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

// 기능 버튼 ( 기존 )
//Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               TextButton(
//                                   onPressed: () {
//                                     PostApi(
//                                             url: startUrl,
//                                             endadr: rsmUrl,
//                                             keyBody: 'stop')
//                                         .Posting();
//                                     setState(() {
//                                       pauseCheck = false;
//                                     });
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "계속 이동",
//                                         style: buttonFont2,
//                                       ),
//                                     ],
//                                   ),
//                                   style: TextButton.styleFrom(
//                                       backgroundColor: Colors.blue,
//                                       fixedSize: Size(
//                                           textButtonWidth, textButtonHeight),
//                                       shape: RoundedRectangleBorder(
//                                           // side: BorderSide(
//                                           //     color: Color(0xFFB7B7B7),
//                                           //     style: BorderStyle.solid,
//                                           //     width: 1),
//                                           borderRadius:
//                                               BorderRadius.circular(40)))),
//                               SizedBox(
//                                 height: textButtonHeight * 0.1,
//                               ),
//                               if (currentGoal != "충전스테이션")
//                                 Column(
//                                   children: [
//                                     TextButton(
//                                         onPressed: () {
//                                           PostApi(
//                                                   url: startUrl,
//                                                   endadr: chgUrl,
//                                                   keyBody: 'charging_pile')
//                                               .Posting();
//                                           _networkProvider.currentGoal =
//                                               '충전스테이션';
//                                           setState(() {
//                                             pauseCheck = false;
//                                           });
//                                         },
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "충전",
//                                               style: buttonFont2,
//                                             ),
//                                           ],
//                                         ),
//                                         style: TextButton.styleFrom(
//                                             backgroundColor:
//                                                 Color.fromRGBO(45, 45, 45, 45),
//                                             fixedSize: Size(textButtonWidth,
//                                                 textButtonHeight),
//                                             shape: RoundedRectangleBorder(
//                                                 // side: BorderSide(
//                                                 //     color: Color(0xFFB7B7B7),
//                                                 //     style: BorderStyle.solid,
//                                                 //     width: 1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         40)))),
//                                     SizedBox(
//                                       height: textButtonHeight * 0.1,
//                                     ),
//                                   ],
//                                 ),
//                               TextButton(
//                                   onPressed: () {
//                                     // Posting(startUrl, navUrl, 대기장소이름);
//                                     setState(() {
//                                       pauseCheck = false;
//                                     });
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "대기장소로 이동",
//                                         style: buttonFont2,
//                                       ),
//                                     ],
//                                   ),
//                                   style: TextButton.styleFrom(
//                                       backgroundColor:
//                                           Color.fromRGBO(45, 45, 45, 45),
//                                       fixedSize: Size(
//                                           textButtonWidth, textButtonHeight),
//                                       shape: RoundedRectangleBorder(
//                                           // side: BorderSide(
//                                           //     color: Color(0xFFB7B7B7),
//                                           //     style: BorderStyle.solid,
//                                           //     width: 1),
//                                           borderRadius:
//                                               BorderRadius.circular(40)))),
//                               SizedBox(
//                                 height: textButtonHeight * 0.1,
//                               ),
//                               if (serviceState == shipping)
//                                 TextButton(
//                                     onPressed: () {
//                                       if (serviceState == shipping) {
//                                         navPage(
//                                                 context: context,
//                                                 page: ShippingDestination(),
//                                                 enablePop: false)
//                                             .navPageToPage();
//                                       }
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "목적지 변경",
//                                           style: buttonFont2,
//                                         ),
//                                       ],
//                                     ),
//                                     style: TextButton.styleFrom(
//                                         backgroundColor:
//                                             Color.fromRGBO(45, 45, 45, 45),
//                                         fixedSize: Size(
//                                             textButtonWidth, textButtonHeight),
//                                         shape: RoundedRectangleBorder(
//                                             // side: BorderSide(
//                                             //     color: Color(0xFFB7B7B7),
//                                             //     style: BorderStyle.solid,
//                                             //     width: 1),
//                                             borderRadius:
//                                                 BorderRadius.circular(40)))),
//                             ],
//                           )

// 디버그용 도착 버튼
//IconButton(
//                                     onPressed: () {
//                                       if (serviceState == shipping) {
//                                         if (_networkProvider.shippingDone ==
//                                             true) {
//                                           navPage(
//                                                   context: context,
//                                                   page: ShippingMenu(),
//                                                   enablePop: false)
//                                               .navPageToPage();
//                                           _networkProvider.shippingDone = false;
//                                         } else {
//                                           navPage(
//                                                   context: context,
//                                                   page: ShippingDone(),
//                                                   enablePop: false)
//                                               .navPageToPage();
//                                         }
//                                       } else if (serviceState == serving) {
//                                         if (_networkProvider.servingDone ==
//                                             true) {
//                                           _servingProvider.clearAllTray();
//                                           _networkProvider.servingDone = false;
//                                           navPage(
//                                                   context: context,
//                                                   page: TraySelection3(),
//                                                   enablePop: false)
//                                               .navPageToPage();
//                                         } else {
//                                           navPage(
//                                                   context: context,
//                                                   page: ServingProgress3(),
//                                                   enablePop: false)
//                                               .navPageToPage();
//                                         }
//                                       }
//                                     },
//                                     iconSize: screenWidth * 0.1,
//                                     color: Color(0xffF0F0F0),
//                                     icon: Icon(
//                                         Icons.pause_circle_outline_outlined),
//                                   ),
