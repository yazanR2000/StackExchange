import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/widgets/save_button.dart';

class QuestionComponent extends StatelessWidget {
  final QueryDocumentSnapshot _post;
  final bool _isProfile;
  final Function _rebuild;
  QuestionComponent(this._post, this._isProfile,this._rebuild);

  bool _isNew(DateTime date) {
    final DateTime dateTime = DateTime.now();
    final diffirence = dateTime.difference(date);
    if (diffirence.inHours < 6) {
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
          if(_post['solvedComment'] != "null")
            Text(
              "Solved",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.green,
                  ),
            ),
          ListTile(
            dense: true,
            onTap: _isProfile
                ? null
                : () {
                    Navigator.of(context)
                        .pushNamed('/profile', arguments: _post['userId']);
                  },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                _post['userImageUrl'],
              ),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(_post['userFullName'].toString()),
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
                  SizedBox(
                    width: 5,
                  ),
                  if (_isNew(DateTime.parse(_post['date'])))
                    const Chip(
                      label: Text(
                        "new",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      backgroundColor: Color(0xFFFF1e1e),
                    ),
                  SaveButton(_post.id),
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
                    Navigator.of(context)
                        .pushNamed("/CommentSheet", arguments: _post.id);
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
                Navigator.of(context).pushNamed("/FullPost", arguments: {
                  'question' : _post,
                  'rebuild' : _rebuild,
                });
              },
              child: Text("See full post"),
            ),
          )
        ],
      ),
    );
  }
}
