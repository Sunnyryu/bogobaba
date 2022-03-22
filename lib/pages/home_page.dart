import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String searchText = "";

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TextEditingController homeSearchController = TextEditingController();
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BogoAppbar(
        title: "Bogobaba",
        numberKey: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: homeSearchController,
              style: TextStyle(color: BogoColor.bogoWhite),
              decoration: InputDecoration(
                filled: true,
                fillColor: BogoColor.bogoDarkGray,
                contentPadding: EdgeInsets.all(10.0),
                hintText: "작품검색",
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
                      if (homeSearchController.text.isNotEmpty) {
                        searchText = homeSearchController.text.trim();
                        homeSearchController.clear();
                      }
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
              onSubmitted: (_) {
                setState(() {
                  if (homeSearchController.text.isNotEmpty) {
                    searchText = homeSearchController.text.trim();
                    homeSearchController.clear();
                  }
                });
              },
            ),
          ),
          TabBar(
            controller: tabController,
            tabs: [
              Tab(text: "Movie"),
              Tab(text: "Drama"),
              Tab(text: "Animation"),
            ],
            indicatorColor: BogoColor.bogoWhite,
          ),
        ],
      ),
    );
  }
}
