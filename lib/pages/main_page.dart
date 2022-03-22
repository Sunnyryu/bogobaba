import 'package:bogobaba/pages/Login_page.dart';
import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/service/movie_service.dart';
import 'package:bogobaba/pages/home_page.dart';
import 'package:bogobaba/pages/my_page.dart';
import 'package:bogobaba/pages/review_page.dart';
import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final authService = context.read<AuthService>();
    // final user = authService.currentUser()!;
    // return Consumer<BucketService>(builder: (context, bucketService, child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            HomePage(),
            ReviewPage(),
            MyPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: BogoColor.bogoFirst,
        currentIndex: currentIndex,
        selectedItemColor: BogoColor.bogoWhite,
        unselectedItemColor: BogoColor.bogoGray,
        showSelectedLabels: true, // 선택된 항목 label 숨기기
        showUnselectedLabels: true, // 선택되지 않은 항목 label 숨기기
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.reviews), label: "리뷰"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이페이지"),
        ],
        onTap: (bogoIndex) {
          setState(() {
            currentIndex = bogoIndex;
          });
        },
      ),
    );
    // });
  }
}
