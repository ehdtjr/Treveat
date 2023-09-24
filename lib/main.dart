import 'package:flutter/material.dart';
import 'package:flutter_app/Mypage/customer_center.dart';
import 'package:flutter_app/Mypage/language.dart';
import 'package:flutter_app/kakao/login_view.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Firstview.dart';
import 'package:flutter_app/tab/map.dart';
import 'package:flutter_app/tab/list.dart';
import 'package:flutter_app/tab/friend.dart';
import 'package:flutter_app/tab/mypage.dart';

import 'Firstview_token.dart';
import 'kakao/login.dart';
import 'kakao/login_view_model.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: 'c2d639ef25b9728ebf587f4578467801');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routes: {
        '/first':(context)=> Firstview(),
        '/first_token':(context)=> Firstview_token(),
        '/map':(context)=> MapScreen(),
        '/list':(context)=> ImageDisplay(),
        '/friend':(context)=> Friend(),
        '/mypage':(context)=> MyPage(),
        '/customer_center':(context) => Customer_center(),
        '/language':(context)=> Language()
      },
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // SharedPreferences에서 로그인 토큰 확인
  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // 로그인 토큰이 있는 경우, 메인 화면으로 이동
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Firstview_token(),
      ));
    } else {
      // 로그인 토큰이 없는 경우, 로그인 화면으로 이동
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Firstview(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('홈 화면'),
//       ),
//       body: Center(
//         child: Text('로그인 되었습니다.'),
//       ),
//     );
//   }
// }

