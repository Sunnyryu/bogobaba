import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BogoAppbar(
        title: "Bogobaba",
        numberKey: 3,
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(text: "내가 쓴 리뷰"),
              Tab(text: "좋아요 누른 리뷰"),
            ],
            indicatorColor: BogoColor.bogoWhite,
          ),
        ],
      ),
    );
  }
}
