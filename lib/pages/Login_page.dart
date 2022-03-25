import 'dart:math';

import 'package:bogobaba/pages/test_page.dart';
import 'package:bogobaba/service/auth_service.dart';
// import 'package:bogobaba/main.dart';
import 'package:bogobaba/pages/main_page.dart';
import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _hideText = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser();
        return Scaffold(
          appBar: BogoAppbar(
            title: "Bogobaba",
            numberKey: 1,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 100),

                /// 이메일
                TextField(
                  scrollPadding: EdgeInsets.only(bottom: 150),
                  style: TextStyle(color: BogoColor.bogoWhite),
                  controller: emailController,
                  cursorColor: BogoColor.bogoGray,
                  decoration: InputDecoration(
                    hintText: "이메일",
                    hintStyle: TextStyle(color: BogoColor.bogoWhite),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: BogoColor.bogoPrimary),
                    // ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: BogoColor.bogoGray),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: BogoColor.bogoGray),
                    ),
                  ),
                ),

                /// 비밀번호
                TextField(
                  controller: passwordController,
                  scrollPadding: EdgeInsets.only(bottom: 120),
                  obscureText: _hideText,
                  style: TextStyle(color: BogoColor.bogoWhite),
                  decoration: InputDecoration(
                    hintText: "비밀번호",
                    hintStyle: TextStyle(color: BogoColor.bogoWhite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: BogoColor.bogoGray),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: BogoColor.bogoGray),
                    ),
                    suffixIcon: IconButton(
                      color: BogoColor.bogoWhite,
                      icon: Icon(
                          _hideText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hideText = !_hideText;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),

                /// 로그인 버튼
                ElevatedButton(
                  child: Text("로그인", style: TextStyle(fontSize: 21)),
                  style: ElevatedButton.styleFrom(
                    primary: BogoColor.bogoFirst,
                    onPrimary: BogoColor.bogoWhite,
                    elevation: 0,
                  ),
                  onPressed: () {
                    // 로그인
                    authService.signIn(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        // 로그인 성공
                        print(emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("로그인 성공"),
                            duration: Duration(seconds: 1),
                          ),
                        );

                        // HomePage로 이동
                        if (emailController.text == "test@a.com") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TestPage()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                        }
                      },
                      onError: (err) {
                        // 에러 발생
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(err),
                        ));
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                /// 회원가입 버튼
                ElevatedButton(
                  child: Text("회원가입", style: TextStyle(fontSize: 21)),
                  style: ElevatedButton.styleFrom(
                    primary: BogoColor.bogoFirst,
                    onPrimary: BogoColor.bogoWhite,
                    elevation: 0,
                  ),
                  onPressed: () {
                    // 회원가입
                    authService.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        // 회원가입 성공
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("회원가입 성공"),
                        ));
                      },
                      onError: (err) {
                        // 에러 발생
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(err),
                        ));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
