import 'package:bogobaba/service/auth_service.dart';
import 'package:bogobaba/service/movie_service.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchPage extends StatefulWidget {
  WatchPage({
    Key? key,
    required this.name,
    required this.imgLink,
    required this.genre,
    required this.year,
    required this.description,
    required this.mid,
    this.originalLink,
  }) : super(key: key);

  String? originalLink;
  final String imgLink;
  final String name;
  final dynamic genre;
  final String description;
  final String year;
  final String mid;

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  int _listNumber = 4;
  String _reviewBox = "전체 리뷰 보기";

  dynamic heartList = [];
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<MovieService>(builder: (context, movieService, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              // snap: false,
              floating: false,
              // stretch: true,

              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        widget.imgLink,
                        fit: BoxFit.fill,
                        color: BogoColor.bogoOpacity,
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                color: BogoColor.bogoWhite,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.year,
                            style: TextStyle(
                                color: BogoColor.bogoGray, fontSize: 16),
                          ),
                          Text(
                            widget.genre.join(", "),
                            style: TextStyle(
                                color: BogoColor.bogoGray, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: movieService.readReview(widget.mid),
                builder: (context, snapshot) {
                  final docs = snapshot.data?.docs ?? [];
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == 0) {
                          return Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "작품정보",
                                  style: TextStyle(
                                      color: BogoColor.bogoWhite, fontSize: 20),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  widget.description,
                                  style: TextStyle(
                                      color: BogoColor.bogoWhite, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "작품 리뷰",
                                      style: TextStyle(
                                        color: BogoColor.bogoWhite,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (_reviewBox == "전체 리뷰 보기") {
                                              _listNumber = docs.length + 1;
                                              _reviewBox = "최소 리뷰 보기";
                                            } else if (_reviewBox ==
                                                "최소 리뷰 보기") {
                                              if (docs.length > 2) {
                                                _listNumber = 4;
                                                _reviewBox = "전체 리뷰 보기";
                                              } else {
                                                _listNumber = docs.length + 1;
                                                _reviewBox = "전체 리뷰 보기";
                                              }
                                            }
                                          },
                                        );
                                      },
                                      child: Text(
                                        _reviewBox,
                                        style: TextStyle(
                                            color: BogoColor.bogoWhite),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          final doc = docs[index - 1];

                          String myId = user.uid;
                          String uid = doc.get('uid');
                          String content = doc.get('content');

                          List likeList = doc.get('likeList');
                          return Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              margin: EdgeInsets.only(bottom: 15),
                              color: BogoColor.bogoDarkGray,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, left: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 18.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              uid.substring(0, 4),
                                              style: TextStyle(
                                                  color: BogoColor.bogoWhite,
                                                  fontSize: 11),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              iconSize: 11.0,
                                              color: likeList.contains(myId)
                                                  ? BogoColor.bogoRed
                                                  : BogoColor.bogoWhite,
                                              icon: likeList.contains(myId)
                                                  ? Icon(Icons.favorite)
                                                  : Icon(Icons.favorite_border),
                                              onPressed: () {
                                                setState(() {
                                                  if (likeList.contains(myId) ==
                                                      true) {
                                                    likeList.remove(myId);
                                                    movieService.updateAddLike(
                                                        doc.id, likeList);
                                                  } else if (likeList
                                                          .contains(myId) ==
                                                      false) {
                                                    likeList.add(myId);
                                                    movieService.updateAddLike(
                                                        doc.id, likeList);
                                                  }
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 60,
                                        child: Text(
                                          content,
                                          style: TextStyle(
                                            color: BogoColor.bogoWhite,
                                            fontSize: 13,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        }
                      },
                      childCount:
                          docs.length > 4 ? _listNumber : docs.length + 1,
                    ),
                  );
                })
          ],
        ),
      );
    });
  }
}
