import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'social_login.dart';
import 'package:http/http.dart' as http;
import 'user_kakao_info.dart' as info;

class KakaoLogin implements SocialLogin {
  @override
  Future login(BuildContext context) async {
    User user;
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      if(isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오어플로 구동');

          final url = Uri.https('kapi.kakao.com', '/v2/user/me');

          final response = await http.get(
            url,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
            },
          );

          TokenManagerProvider.instance.manager.setToken(token);

          User user = await UserApi.instance.me();

          print('response ${token.accessToken}');
          info.token = token.accessToken;
          info.nickname = user.kakaoAccount!.profile!.nickname!;
          info.profileImg = user.kakaoAccount!.profile!.profileImageUrl!;

          Navigator.pushReplacementNamed(context, '/first_token');
          // return true;
        }
        catch(error) {
          print(error);
          // return false;
        }
      }
      else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 구동');

          final url = Uri.https('kapi.kakao.com', '/v2/user/me');

          final response = await http.get(
            url,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
            },
          );

          TokenManagerProvider.instance.manager.setToken(token);

          User user = await UserApi.instance.me();

          print('response ${token.accessToken}');
          info.token = token.accessToken;
          info.nickname = user.kakaoAccount!.profile!.nickname!;
          info.profileImg = user.kakaoAccount!.profile!.profileImageUrl!;
          print(user.kakaoAccount!.profile!.profileImageUrl);

          Navigator.pushReplacementNamed(context, '/first_token');
        }
        catch(error) {
          print(error);
        }
      }
    }
    catch(error) {
      print(error);
    }
  }
  @override
  Future logout(BuildContext context) async {
    try {
      await UserApi.instance.unlink();
      Navigator.pushReplacementNamed(context, '/map');
    }
    catch(error) {
      // return false;
    }
  }
}