import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habits/Auth/login_view.dart';
import 'package:habits/Auth/register.dart';
import 'package:habits/firebase/auth.dart';
import 'package:habits/home.dart';

class Switcher extends StatelessWidget {
  static final isLogin = ValueNotifier(true);

  const Switcher({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FBAuth.userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if(snapshot.hasData) {
            print('email: ${FBAuth.user?.email}');
            return Home();
          } else{
            return ValueListenableBuilder(
              builder: (context, value, child) {
                return value ?LoginView(): Register();
              },valueListenable: isLogin,
            );
          }
        });
  }
}
