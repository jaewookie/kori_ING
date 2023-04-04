import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/callApi.dart';
import 'package:kori_test_refactoring/Utills/getAPI.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
import 'package:kori_test_refactoring/screens/MainScreen.dart';
import 'package:provider/provider.dart';

class IpChange extends StatefulWidget {
  const IpChange({Key? key}) : super(key: key);

  @override
  State<IpChange> createState() => _IpChangeState();
}

class _IpChangeState extends State<IpChange> {
  late NetworkModel _networkProvider;

  dynamic getApiData;
  String? ipAddress;

  String positionURL="";

  TextEditingController controller = TextEditingController();
  //
  // dynamic getting(String hostUrl, String endUrl) async {
  //   String hostIP = hostUrl;
  //   String endPoint = endUrl;
  //
  //   String apiAddress = hostIP+endPoint;
  //
  //   NetworkGet network = NetworkGet(apiAddress);
  //
  //   dynamic getApiData = await network.getAPI();
  //
  //   print(getApiData);
  //
  //   navPage(context: context, page: MainScreen(parsePoseData: getApiData,), enablePop: true).navPageToPage();
  // }


  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.3;
    double textButtonHeight = screenHeight * 0.1;

    TextStyle? bgFont = Theme.of(context).textTheme.displayMedium;
    TextStyle? buttonFont = Theme.of(context).textTheme.headlineLarge;

    ipAddress = _networkProvider.startUrl;
    positionURL = _networkProvider.positionURL;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            // padding: EdgeInsets.only(right: screenWidth * 0.07),
            padding: EdgeInsets.fromLTRB(
                0, screenHeight * 0.0015, screenWidth * 0.05, 0),
            onPressed: () {
              navPage(context: context, page: MainScreen(), enablePop: false)
                  .navPageToPage();
            },
            icon: Icon(
              Icons.home_outlined,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.05,
          )
        ],
        toolbarHeight: screenHeight * 0.08,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/KoriBackgroundImage_v1.png"),
                fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: screenHeight * 0.1),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    Text(
                      '현재 호스트 IP',
                      style: bgFont,
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    Text(
                      '$ipAddress',
                      style: TextStyle(
                          fontFamily: 'kor',
                          fontWeight: FontWeight.bold,
                          fontSize: 65,
                          color: Color(0xffF0F0F0),
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Container(
                  width: screenWidth * 0.8,
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter New Ip Address',
                      contentPadding: EdgeInsets.all(30),
                      labelStyle: TextStyle(
                        fontFamily: 'kor',
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Color(0xffFFFFFF),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffF0F0F0),
                            width: 5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffF0F0F0),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xffF0F0F0),
                    style: const TextStyle(
                      fontFamily: 'kor',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.15,
                ),
                TextButton(
                    onPressed: () {
                      if(controller.text!="") {
                        _networkProvider.startUrl = controller.text;
                        print(controller.text);
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 2),
                          content: const Text('호스트 IP가 변경 되었습니다.'),
                          backgroundColor: Color.fromRGBO(49, 49, 49, 50),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        _networkProvider.hostIP();

                        print(_networkProvider.startUrl);

                        ipAddress = _networkProvider.startUrl;

                        getApiData = GetApi(url: ipAddress!, endadr: positionURL);
                        navPage(context: context, page: MainScreen(parsePoseData: getApiData,), enablePop: true).navPageToPage();

                        // getting(ipAddress!, positionURL);
                        // navPage(
                        //         context: context,
                        //         page: MainScreen(),
                        //         enablePop: false)
                        //     .navPageToPage();
                      }else{
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 2),
                          content: const Text('호스트 IP를 입력 해 주세요'),
                          backgroundColor: Color.fromRGBO(49, 49, 49, 50),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: textButtonWidth * 0.033,
                        ),
                        SizedBox(
                          width: textButtonWidth * 0.44,
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: Color(0xffF0F0F0),
                            size: 60,
                          ),
                        ),
                        Text(
                          '적용',
                          style: const TextStyle(
                            fontFamily: 'kor',
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color(0xffF0F0F0),
                          ),
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        // backgroundColor: Color(0xFF2D2D2D),
                        fixedSize: Size(textButtonWidth, textButtonHeight),
                        shape: RoundedRectangleBorder(
                            // side: BorderSide(
                            //     color: Color(0xFFB7B7B7),
                            //     style: BorderStyle.solid,
                            //     width: 1),
                            borderRadius: BorderRadius.circular(40))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
