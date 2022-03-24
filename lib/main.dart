import 'package:bogobaba/pages/Login_page.dart';
import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/service/movie_service.dart';
import 'package:bogobaba/pages/main_page.dart';
import 'package:bogobaba/service/review_service.dart';
import 'package:bogobaba/widgets/colors.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ReviewService()),
        ChangeNotifierProvider(create: (context) => MovieService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: BogoColor.bogoFirst,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: BogoColor.bogoFirst,
      ),

      home: user == null ? LoginPage() : MainPage(),
      // user 있으면 넘어가고 없으면
    );
  }
}

/// 홈페이지
