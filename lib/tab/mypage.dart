import 'package:flutter/material.dart';
import 'package:flutter_app/kakao/login.dart';
import '../kakao/login_view_model.dart';
import 'package:flutter_app/kakao/user_kakao_info.dart' as info;
import 'package:flutter_app/Mypage/update_info.dart';

class MyPage extends StatelessWidget {
  final viewModel = loginViewModel(KakaoLogin());

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(
          onSubmitted: (userInput) {
            // 사용자 입력 처리
            print('사용자 입력: $userInput');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Treveat', style: TextStyle(color: Color(0xff69E2E3))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height:1.0,
              width:500.0,
              color:Color(0xffe5e5e5)),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30),
                    child:
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(info.profileImg),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        _showInputDialog(context);
                      },
                      child:
                      Container(
                          margin: EdgeInsets.only(top:55),
                          child: Icon(Icons.create, size: 15, color: Color(0xffe5e5e5))
                      )
                  )
                ]
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 245,
                          height: 25,
                          margin: EdgeInsets.only(top: 28, left: 15),
                          child:
                          Text("${info.nickname}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                      ),
                      GestureDetector(
                          onTap: () {
                            _showInputDialog(context);
                          },
                          child:
                            Container(
                              margin: EdgeInsets.only(top:22),
                              child: Icon(Icons.create, size: 15, color: Color(0xffe5e5e5))
                            )
                      )
                    ]
                  ),
                  Row(
                    children: [
                      Container(
                          width: 245,
                          height: 20,
                          margin: EdgeInsets.only(top: 3, left: 15),
                          child:
                          Text("짧은 소개를 입력해주세요.",
                            style: TextStyle(
                                fontSize: 13),
                          )
                      ),
                      GestureDetector(
                          onTap: () {
                            _showInputDialog(context);
                          },
                          child:
                          Container(
                              margin: EdgeInsets.only(top:2),
                              child: Icon(Icons.create, size: 15, color: Color(0xffe5e5e5))
                          )
                      )
                    ],
                  )
                ]
              )
            ]
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20, left: 30),
                  child: Icon(Icons.do_not_disturb_alt, size: 35, color: Color(0xff69E2E3))
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                width: 70, height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffe5e5e5),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("(키워드1)",
                            style: TextStyle(
                                fontSize: 11
                      )),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                width: 70, height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xffe5e5e5),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("(키워드2)",
                    style: TextStyle(
                        fontSize: 11
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                width: 70, height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xffe5e5e5),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("(키워드3)",
                    style: TextStyle(
                        fontSize: 11
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  child: Icon(Icons.check_box, size: 20, color: Color(0xffe5e5e5))
              )
            ]
          ),
          Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 12, left: 30),
                    child: Icon(Icons.
                    sentiment_very_satisfied
                        , size: 35, color: Color(0xff69E2E3))
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 20),
                  width: 70, height: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xffa6feff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text("(키워드1)",
                      style: TextStyle(
                          fontSize: 11
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 20),
                  width: 70, height: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xffa6feff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text("(키워드2)",
                      style: TextStyle(
                          fontSize: 11
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 20),
                  width: 70, height: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xffa6feff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text("(키워드3)",
                      style: TextStyle(
                          fontSize: 11
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15, left: 20),
                    child: Icon(Icons.check_box, size: 20, color: Color(0xff69E2E3))
                )
              ]
          ),
          Container(
              height:1.0,
              width:500.0,
              margin: EdgeInsets.only(top: 20),
              color:Color(0xffe5e5e5)),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20, left: 30),
                  child: Icon(Icons.favorite, size: 33, color: Color(0xff69E2E3))
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, left: 27),
                  child:
                  Text("즐겨찾기",
                    style: TextStyle(
                        fontSize: 16),
                  )
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/language');
                },
                child:
                  Container(
                      margin: EdgeInsets.only(top: 20, left: 30),
                      child: Icon(Icons.translate, size: 33, color: Color(0xff69E2E3))
                  )
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/language');
                },
                child:
                  Container(
                      margin: EdgeInsets.only(top: 20, left: 27),
                      child:
                      Text("언어",
                        style: TextStyle(
                            fontSize: 16),
                      )
                  )
              )
            ],
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20, left: 30),
                  child: Icon(Icons.border_color, size: 33, color: Color(0xff69E2E3))
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, left: 27),
                  child:
                  Text("내가 작성한 리뷰",
                    style: TextStyle(
                        fontSize: 16),
                  )
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/customer_center');
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 30),
                    child: Icon(Icons.face, size: 33, color: Color(0xff69E2E3))
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/customer_center');
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 27),
                    child:
                    Text("고객센터",
                      style: TextStyle(
                          fontSize: 16),
                    )
                ),
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async{
                  await viewModel.logout(context);
                  },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 30),
                    child: Icon(Icons.logout, size: 33, color: Color(0xff69E2E3))
                ),
              ),
              GestureDetector(
                onTap: () async{
                  await viewModel.logout(context);
                  },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 27),
                    child:
                    Text("로그아웃",
                      style: TextStyle(
                          fontSize: 16),
                    )
                )
              ),
            ],
          )
        ]
      ),
    );
  }
}
