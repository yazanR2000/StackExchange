import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/widgets/save_button.dart';

class QuestionComponent extends StatefulWidget {
  final QueryDocumentSnapshot _post;
  final bool _isProfile;
  final Function _rebuild;
  QuestionComponent(this._post, this._isProfile, this._rebuild);

  @override
  State<QuestionComponent> createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  bool _isNew(DateTime date) {
    final DateTime dateTime = DateTime.now();
    final diffirence = dateTime.difference(date);
    if (diffirence.inHours < 6) {
      return true;
    }
    return false;
  }

  bool bookmark = false;
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
          if (widget._post['solvedComment'] != "null")
            Text(
              "Solved",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.green,
                  ),
            ),
          ListTile(
            dense: true,
            onTap: widget._isProfile
                ? null
                : () {
                    Navigator.of(context).pushNamed('/profile',
                        arguments: widget._post['userId']);
                  },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                widget._post['userImageUrl'],
              ),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(widget._post['userFullName'].toString()),
            subtitle: Text(widget._post['date'].toString().substring(0, 10)),
            trailing: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Chip(
                    backgroundColor: Color(0xff),
                    label: Text(
                      widget._post['type'],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (_isNew(DateTime.parse(widget._post['date'])))
                    const Chip(
                      label: Text(
                        "new",
                        style: TextStyle(color: Colors.white, fontSize: 15),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            widget._post['questionTitle'],
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              widget._post['description'].toString().length > 200
                  ? "${widget._post['description'].toString().substring(0, 200)}..."
                  : widget._post['description'].toString(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/CommentSheet", arguments: widget._post.id);
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
                  'question': widget._post,
                  'rebuild': widget._rebuild,
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
