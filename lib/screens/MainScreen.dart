import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
// import 'package:kori_test_refactoring/Utills/navScreens.dart';
// import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
// import 'package:kori_test_refactoring/screens/AdminScreen.dart';
// import 'package:kori_test_refactoring/screens/ConfigScreen.dart';
// import 'package:kori_test_refactoring/screens/LinkConnectorScreen.dart';
// import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
// import 'package:kori_test_refactoring/screens/modules/mainScreenButtons.dart';
import 'package:kori_test_refactoring/screens/modules/mainScreenButtonsNew.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.parsePoseData}) : super(key: key);
  final dynamic parsePoseData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late NetworkModel _networkProvider;

  dynamic newPoseData;
  dynamic poseData;

  // double? buttonIconSize;

  DateTime? currentBackPressTime;
  final String _text = "뒤로가기 버튼을 한 번 더 누르시면 앱이 종료됩니다.";

  final String _wallpape = "final_assets/screens/koriZFinalHome.png";
  final String _fingerIcon = "final_assets/icons/pushIcon.png";

  // 버튼 아이콘 및 텍스트 직접 입력
  // late var mainButtonName = List<String>.empty();
  // late var mainButtonIcon = List<IconData>.empty();

  // 버튼 디자인 위에 올리기
  double pixelRatio = 0.75;

  //
  // late List<double> buttonPositionWidth;
  // late List<double> buttonPositionHeight;
  // late List<double> buttonSize;
  //
  // late int buttonsNumbers;
  //
  // int buttonWidth = 0;
  // int buttonHeight = 1;

  late final AnimationController _textAniCon = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _textAniCon,
    curve: Curves.easeOut,
  );

  FToast? fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast?.init(context);

    // String buttonName1 = "서비스 시작";
    // String buttonName2 = "커넥터 연결";
    // String buttonName3 = "관리자 메뉴";
    // String buttonName4 = "설정";
    //
    // mainButtonName = [buttonName1, buttonName2, buttonName3, buttonName4];

    // IconData appIcon1 = Icons.link;
    // IconData appIcon2 = Icons.admin_panel_settings;
    // IconData appIcon3 = Icons.settings;
    //
    // mainButtonIcon = [appIcon1, appIcon1, appIcon2, appIcon3];

    // buttonIconSize = 120;

    poseDataUpdate(widget.parsePoseData);
  }

  void poseDataUpdate(dynamic parsePoseData) {
    newPoseData = parsePoseData;
    if (newPoseData != null) {
      poseData = newPoseData;
    }
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    // 버튼 디자인 위에 올리기
    // buttonPositionWidth = [121, 747, 121, 747];
    // buttonPositionHeight = [400, 400, 1021, 1021];
    //
    // buttonSize = [570, 565];
    //
    // buttonsNumbers = buttonPositionHeight.length;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TextStyle? buttonFont = Theme.of(context).textTheme.displayLarge;

    print('a: $poseData');

    // poseData ??= _networkProvider.getPoseData;
    if (poseData == null) {
      poseData = _networkProvider.getPoseData;
    }

    _networkProvider.getPoseData = poseData;

    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(milliseconds: 1300)) {
          currentBackPressTime = now;
          fToast?.showToast(
              toastDuration: Duration(milliseconds: 1300),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      color: Color(0xff191919),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageIcon(
                            AssetImage('assets/logos/ExaIcon.png'),
                            size: 25,
                            color: Color(0xffB7B7B7),
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Text(
                            _text,
                            style: Theme.of(context).textTheme.headlineLarge,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    )
                  ],
                ),
              ),
              gravity: ToastGravity.BOTTOM);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            Icon(Icons.battery_charging_full,
                color: Colors.teal, size: screenHeight * 0.03),
            SizedBox(width: screenWidth * 0.03)
          ],
          toolbarHeight: screenHeight * 0.045,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(_wallpape))),
            child: Container(),
          ),
          FinalMainScreenButtons(screens: 0),
          Positioned(
              left: 670 * pixelRatio,
              top: 1829 * pixelRatio,
              child: FadeTransition(
                opacity: _animation,
                child: SizedBox(
                  child: ImageIcon(
                    AssetImage(_fingerIcon),
                    color: Color(0xffB7B7B7),
                    size: 100,
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 1970 * pixelRatio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '원하는 메뉴를 선택해주세요.',
                  style: TextStyle(
                      fontFamily: 'kor',
                      fontSize: 35,
                      color: Color(0xfff0f0f0)),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
