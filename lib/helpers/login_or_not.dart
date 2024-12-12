import 'package:flutter/material.dart';
import 'package:qumon/helpers/user_info.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/login_page.dart';


class LoginOrNot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserInfo.isLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          bool isLogin = snapshot.data ?? false;
          if (isLogin) {
            return Homepage();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}