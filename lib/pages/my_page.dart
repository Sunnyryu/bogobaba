import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/service/review_service.dart';
import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<ReviewService>(
      builder: (context, reviewService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              // centerTitle: true,
              leading: null,
              elevation: 0,
              title: Text(
                "Bogobaba",
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
            ),
            body: TabBarView(children: [
              FutureBuilder<QuerySnapshot>(
                  future: reviewService.readMyReview(user.uid),
                  builder: (context, snapshot) {
                    final documents = snapshot.data?.docs ?? [];
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final doc = documents[index];
                          String movieName = doc.get("name");
                          String review = doc.get("content");
                          String reviewId = doc.id;
                          return ListTile(
                            title: Text(
                              movieName,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              review,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  reviewService.delete(reviewId);
                                });
                              },
                              icon: Icon(Icons.remove),
                              color: BogoColor.bogoWhite,
                            ),
                          );
                        });
                  }),
              Center(
                  child: Text(
                'test2',
                style: TextStyle(color: Colors.white),
              )),
            ]),
          ),
        );
      },
    );
  }
}
