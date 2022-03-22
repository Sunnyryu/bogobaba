// 추후 작업 후에 삭제할 파일입니다.

import 'package:bogobaba/pages/Login_page.dart';
import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/widgets/colors.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class BogoAppbar extends StatefulWidget with PreferredSizeWidget {
  BogoAppbar({
    Key? key,
    required this.title,
    this.controller,
    this.numberKey,
    this.onSearch,
  }) : super(key: key);
  final String title;
  dynamic controller;
  int? numberKey;
  void Function(String)? onSearch;
  @override
  Size get preferredSize => Size.fromHeight(100);

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
        bottom: PreferredSize(
          preferredSize: Size.fromWidth(5),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: widget.controller,
              style: TextStyle(color: BogoColor.bogoWhite),
              decoration: InputDecoration(
                filled: true,
                fillColor: BogoColor.bogoDarkGray,
                contentPadding: EdgeInsets.all(10.0),
                hintText: "검색하기",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: BogoColor.bogoFirst),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: BogoColor.bogoFirst),
                ),
                hintStyle: TextStyle(
                  color: BogoColor.bogoWhite,
                ),
                suffixIcon: IconButton(
                  color: BogoColor.bogoWhite,
                  onPressed: () {
                    setState(() {
                      if (widget.controller.text.isNotEmpty) {
                        widget.onSearch!((() {
                          return _searchtext = widget.controller.text;
                        })());
                        widget.controller.clear();
                      }
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
              onSubmitted: (_) {
                setState(() {
                  if (widget.controller.text.isNotEmpty) {
                    widget.onSearch!((() {
                      _searchtext = widget.controller.text;
                      return _searchtext;
                    })());
                    widget.controller.clear();
                  }
                });
              },
            ),
          ),
        ),
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
        bottom: TabBar(
          controller: widget.controller,
          tabs: [
            Tab(text: "내가 쓴 리뷰"),
            Tab(text: "좋아요 누른 리뷰"),
          ],
          indicatorColor: BogoColor.bogoWhite,
        ),
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
