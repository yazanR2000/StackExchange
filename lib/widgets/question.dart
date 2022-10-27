import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionComponent extends StatelessWidget {
  final QueryDocumentSnapshot _post;
  QuestionComponent(this._post);
  bool _isNew(DateTime date) {
    final DateTime dateTime = DateTime.now();
    final diffirence = dateTime.difference(date);
    if (diffirence.inHours < 12) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/profile', arguments: _post['userId']);
            },
            leading: const Icon(
              Icons.person,
              size: 40,
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(_post['userFullName'].toString().replaceRange(12, _post['userFullName'].toString().length, '...')),
            subtitle: Text(_post['date'].toString().substring(0, 10)),
            trailing: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Chip(
                    backgroundColor: Color(0xff),
                    label: Text(
                      _post['type'],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 5,),
                  if (_isNew(DateTime.parse(_post['date'])))
                    const Chip(
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
          Text(
            _post['questionTitle'],
            style: Theme.of(context).textTheme.bodyText1,
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
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/FullPost", arguments: _post);
              },
              child: Text("See full post"),
            ),
          )
        ],
      ),
    );
  }
}
