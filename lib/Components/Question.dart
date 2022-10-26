import 'package:flutter/material.dart';
import 'package:stackexchange/Components/CommentsSheet.dart';

class QuestionComponent extends StatefulWidget {
  const QuestionComponent({super.key});

  @override
  State<QuestionComponent> createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  bool bookmark = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(20),
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/download.png'),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text("ahmad"),
            subtitle: Text("10/1/2022"),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Chip(
                    label: Text(
                      "new",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(0xFFFF1e1e),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        bookmark = !bookmark;
                      });
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: bookmark ? Colors.blue : Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
                'testestestestetsetsetsetsetestsetestfdgsfdgsfdgfdgdgfsdgfsdgfdgfgfdgfdgsfggfasdfasdfasfsdhughgyuguyyuyu87yughuhygwre98rtyushushgestestsetsetsetsetestestestsestestesteste'),
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((BuildContext context) {
                                    return CommentSheet();
                                  }));
                            },
                            icon: Icon(Icons.add_a_photo)),
                        contentPadding: EdgeInsets.only(top: 1, left: 6),
                        hintText: "Write your solution",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: Text("See full post"))
        ],
      ),
    );
  }
}
