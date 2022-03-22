import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/service/review_service.dart';
import 'package:bogobaba/widgets/appbar.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

String searchText = "";

// show dialog 이용 => 검색 => 이름 및 썸네일 나오고 선택 => 다음 => 값을 넘겨줌 => 새페이지로
class _ReviewPageState extends State<ReviewPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;

    return Consumer<ReviewService>(builder: (context, reviewService, child) {
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
                controller: searchController,
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
                        if (searchController.text.isNotEmpty) {
                          searchText = searchController.text.trim();
                          searchController.clear();
                        }
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
                onSubmitted: (_) {
                  setState(() {
                    if (searchController.text.isNotEmpty) {
                      searchText = searchController.text.trim();
                      searchController.clear();
                    }
                  });
                },
              ),
            ),
            searchText.isNotEmpty
                ? Expanded(
                    //API콜을 해서 응답을 받기 전까지는 로딩 위젯를 보여주고
                    // 성공 응답을 받으면 데이터를 보여주는 위젯을 보여주고
                    // 실패 응답을 받으면 에러메세지를 보여주는 위젯을 보여주고
                    // 싶을때 쓰는 위젯
                    child: FutureBuilder<QuerySnapshot>(
                        future: reviewService.read(searchText),
                        builder: (context, snapshot) {
                          final docs = snapshot.data?.docs ?? []; // 문서들 가져오기

                          return ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              final doc = docs[index];

                              String name = doc.get('name');
                              String imgLink = doc.get('imgLink');
                              String mid = doc.get('mid');

                              return ListTile(
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

                                // 삭제 아이콘 버튼
                                trailing: TextButton(
                                  child: Text("리뷰작성",
                                      style: TextStyle(
                                          color: BogoColor.bogoWhite)),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(name),
                                        content: Row(
                                          children: [
                                            Text("리뷰작성: "),
                                            Expanded(
                                              child: TextField(
                                                maxLines: 10,
                                                minLines: 1,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                controller: reviewController,
                                                decoration: InputDecoration(
                                                  hintText: "리뷰를 작성해주세요.",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // testcontroller.clear();
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (reviewController
                                                  .text.isNotEmpty) {
                                                reviewService.create(
                                                    user.uid,
                                                    reviewController.text,
                                                    mid,
                                                    name);
                                                reviewController.clear();
                                                // Navigator.pop(context, 'OK');
                                              }
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('작성'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }),
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 100),
                      child: Text(
                        "작품을 검색 해주세요",
                        style:
                            TextStyle(color: BogoColor.bogoWhite, fontSize: 24),
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
