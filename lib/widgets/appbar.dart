import 'package:bogobaba/pages/Login_page.dart';
import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/widgets/colors.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class BogoAppbar extends StatefulWidget with PreferredSizeWidget {
  BogoAppbar({
    Key? key,
    required this.title,
    this.numberKey,
  }) : super(key: key);
  final String title;
  // dynamic controller;
  int? numberKey;

  @override
  Size get preferredSize => Size.fromHeight(52);

  @override
  State<BogoAppbar> createState() => _BogoAppbarState();
}

class _BogoAppbarState extends State<BogoAppbar> {
  @override
  @override
  Widget build(BuildContext context) {
    String _searchtext;

    if (widget.numberKey == 1) {
      return AppBar(
        // centerTitle: true,
        leading: null,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
              color: BogoColor.bogoWhite, fontWeight: FontWeight.bold),
        ),
        actions: [],
      );
    } else if (widget.numberKey == 2) {
      return AppBar(
        // centerTitle: true,
        leading: null,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
              color: BogoColor.bogoWhite, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            child: Text(
              "로그아웃",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // 로그아웃
              context.read<AuthService>().signOut();

              // 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      );
    } else if (widget.numberKey == 3) {
      return AppBar(
        // centerTitle: true,
        leading: null,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
              color: BogoColor.bogoWhite, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            child: Text(
              "로그아웃",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // 로그아웃
              context.read<AuthService>().signOut();

              // 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      );
    }
    return AppBar(
      // centerTitle: true,
      leading: null,
      elevation: 0,
      title: Text(
        widget.title,
        style:
            TextStyle(color: BogoColor.bogoWhite, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          child: Text(
            "로그아웃",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            // 로그아웃
            context.read<AuthService>().signOut();

            // 로그인 페이지로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );
  }
}

class mypageAppbar extends StatelessWidget {
  const mypageAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // centerTitle: true,
      leading: null,
      elevation: 0,
      title: Text(
        "Bogobaba",
        style:
            TextStyle(color: BogoColor.bogoWhite, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          child: Text(
            "로그아웃",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            // 로그아웃
          },
        ),
      ],
      bottom: const TabBar(
        isScrollable: false,
        indicatorWeight: 4,
        tabs: [
          Tab(text: "내가 쓴 리뷰"),
          Tab(text: "좋아요 누른 리뷰"),
        ],
        indicatorColor: BogoColor.bogoWhite,
      ),
    );
  }
}
