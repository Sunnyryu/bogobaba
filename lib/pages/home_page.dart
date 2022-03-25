import 'package:bogobaba/pages/watch_page.dart';
import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/service/movie_service.dart';
import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<MovieService>(builder: (context, movieService, child) {
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
                onChanged: (String value) {
                  value = homeSearchController.text.trim();

                  if (value.length > 1) {
                    setState(() {
                      searchText = value;
                    });
                  }
                },
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
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Column(
                    children: [
                      searchText.isNotEmpty
                          ? Expanded(
                              child: FutureBuilder<QuerySnapshot>(
                                future: movieService.read(searchText),
                                builder: (context, snapshot) {
                                  final docs =
                                      snapshot.data?.docs ?? []; // 문서들 가져오기

                                  return ListView.builder(
                                    itemCount: docs.length,
                                    itemBuilder: (context, index) {
                                      final doc = docs[index];
                                      String name = doc.get('name');
                                      String imgLink = doc.get('imgLink');
                                      String mid = doc.get('mid');
                                      String category = doc.get('category');
                                      List genre = doc.get('genre');
                                      String year = doc.get('year');
                                      String originalLink =
                                          doc.get('originalLink');
                                      String description =
                                          doc.get('description');

                                      return category == "movie"
                                          ? ListTile(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WatchPage(
                                                      name: name,
                                                      imgLink: imgLink,
                                                      mid: mid,
                                                      genre: genre,
                                                      description: description,
                                                      year: year,
                                                      originalLink:
                                                          originalLink,
                                                    ),
                                                  ),
                                                );
                                              },
                                              contentPadding: EdgeInsets.only(
                                                  top: 20, left: 10, right: 10),
                                              leading: SizedBox(
                                                width: 100,
                                                child: Image.network(imgLink,
                                                    fit: BoxFit.fill),
                                              ),
                                              title: Text(
                                                name,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: BogoColor.bogoWhite,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
                            )
                          : Center(
                              heightFactor: 10.0,
                              child: Text(
                                "검색을 해주세요",
                                style: TextStyle(
                                    color: BogoColor.bogoWhite, fontSize: 18),
                              ),
                            ),
                    ],
                  ),
                  Column(
                    children: [
                      searchText.isNotEmpty
                          ? Expanded(
                              child: FutureBuilder<QuerySnapshot>(
                                future: movieService.read(searchText),
                                builder: (context, snapshot) {
                                  final docs =
                                      snapshot.data?.docs ?? []; // 문서들 가져오기

                                  return ListView.builder(
                                    itemCount: docs.length,
                                    itemBuilder: (context, index) {
                                      final doc = docs[index];
                                      String name = doc.get('name');
                                      String imgLink = doc.get('imgLink');
                                      String mid = doc.get('mid');
                                      String category = doc.get('category');
                                      List genre = doc.get('genre');
                                      String year = doc.get('year');
                                      String originalLink =
                                          doc.get('originalLink');
                                      String description =
                                          doc.get('description');

                                      return category == "drama"
                                          ? ListTile(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WatchPage(
                                                      name: name,
                                                      imgLink: imgLink,
                                                      mid: mid,
                                                      genre: genre,
                                                      description: description,
                                                      year: year,
                                                      originalLink:
                                                          originalLink,
                                                    ),
                                                  ),
                                                );
                                              },
                                              contentPadding: EdgeInsets.only(
                                                  top: 20, left: 10, right: 10),
                                              leading: Image.network(imgLink,
                                                  width: 70, fit: BoxFit.fill),
                                              title: Text(
                                                name,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: BogoColor.bogoWhite,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
                            )
                          : Center(
                              heightFactor: 10.0,
                              child: Text(
                                "검색을 해주세요",
                                style: TextStyle(
                                    color: BogoColor.bogoWhite, fontSize: 18),
                              ),
                            ),
                    ],
                  ),
                  Column(
                    children: [
                      searchText.isNotEmpty
                          ? Expanded(
                              child: FutureBuilder<QuerySnapshot>(
                                future: movieService.read(searchText),
                                builder: (context, snapshot) {
                                  final docs =
                                      snapshot.data?.docs ?? []; // 문서들 가져오기

                                  return ListView.builder(
                                    itemCount: docs.length,
                                    itemBuilder: (context, index) {
                                      final doc = docs[index];
                                      String name = doc.get('name');
                                      String imgLink = doc.get('imgLink');
                                      String mid = doc.get('mid');
                                      String category = doc.get('category');
                                      List genre = doc.get('genre');
                                      String year = doc.get('year');
                                      String originalLink =
                                          doc.get('originalLink');
                                      String description =
                                          doc.get('description');

                                      return category == "animation"
                                          ? ListTile(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WatchPage(
                                                      name: name,
                                                      imgLink: imgLink,
                                                      mid: mid,
                                                      genre: genre,
                                                      description: description,
                                                      year: year,
                                                      originalLink:
                                                          originalLink,
                                                    ),
                                                  ),
                                                );
                                              },
                                              contentPadding: EdgeInsets.only(
                                                  top: 20, left: 10, right: 10),
                                              leading: Image.network(imgLink,
                                                  width: 70, fit: BoxFit.fill),
                                              title: Text(
                                                name,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: BogoColor.bogoWhite,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
                            )
                          : Center(
                              heightFactor: 10.0,
                              child: Text(
                                "검색을 해주세요",
                                style: TextStyle(
                                    color: BogoColor.bogoWhite, fontSize: 18),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
