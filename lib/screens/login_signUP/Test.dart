import 'package:flutter/material.dart';

import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:stackexchange/widgets/TextCode.dart';

class testPage extends StatefulWidget {
  const testPage({super.key});
  static const String screenRoute = "test";

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  bool x = false;
  static String? code = r'hi';

  TextEditingController codeText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Syntax View Example"),
        backgroundColor: Colors.blueGrey[800],
        elevation: 6,
      ),
      body: ListView(children: [
        TextField(
          minLines: 5,
          maxLines: 10,
          controller: codeText,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                //code = ;
                //x = !x;
                TextCode.textCodeEditor = codeText.text;
                codeText.clear();
              });
            },
            child: Text("done")),
        TextCode(),
      ]),
    );
  }
}
