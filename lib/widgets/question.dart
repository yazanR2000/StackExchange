import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionComponent extends StatelessWidget {
  final QueryDocumentSnapshot _post;
  QuestionComponent(this._post);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/profile', arguments: _post['userId']);
            },
            leading: const Icon(
              Icons.person,
              size: 40,
            ),
            contentPadding: EdgeInsets.zero,
            title: Text("ahmad"),
            subtitle: Text(_post['date'].toString().substring(0, 10)),
            trailing: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    label: Text(
                      "new",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    backgroundColor: Color(0xFFFF1e1e),
                  ),
                  IconButton(
                    onPressed: () {
                      // setState(() {
                      //   bookmark = !bookmark;
                      // });
                    },
                    icon: Icon(
                      Icons.bookmark,
                      //color: bookmark ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(_post['description'].toString()),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/CommentSheet");
                  },
                  child: Text("Write your solution"),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/FullPost",arguments: _post);
            },
            child: Text("See full post"),
          )
        ],
      ),
    );
  }
}
