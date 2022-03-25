import 'package:bogobaba/service/test_service.dart';
import 'package:bogobaba/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String appName = dotenv.get('NAVER_KEY');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("testpage"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              TestService();
            },
            child: Text("테스트"),
          ),
          Text(appName),
        ],
      ),
    );
  }
}
