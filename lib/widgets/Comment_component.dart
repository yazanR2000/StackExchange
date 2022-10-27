import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {
  final QueryDocumentSnapshot _comment;
  CommentComponent(this._comment);

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  String? _vote;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(widget._comment['userFullName']),
            subtitle: Text(widget._comment['date'].toString().substring(0, 16)),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _vote = "up";
                        });
                      },
                      icon: Icon(
                        Icons.arrow_circle_up,
                        color: _vote == "up" ? Colors.blue : Colors.black,
                        size: 30,
                      )),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _vote = "down";
                      });
                    },
                    icon: Icon(
                      Icons.arrow_circle_down,
                      color: _vote == "down" ? Colors.blue : Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(widget._comment['comment']),
          ),
          Column(
            children: List.generate(
              widget._comment['images'].length,
              (index) => Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget._comment['images'][index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
