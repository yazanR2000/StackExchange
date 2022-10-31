import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/question.dart' as q;

class CommentComponent extends StatefulWidget {
  final QueryDocumentSnapshot _comment;
  final bool questionOwner;
  final QueryDocumentSnapshot _question;
  final Function _rebuild;
  CommentComponent(
    this._comment,
    this.questionOwner,
    this._question,
    this._rebuild,
  );

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.questionOwner &&
              widget._question['solvedComment'] == "null")
            OutlinedButton(
              onPressed: () async {
                try {
                  await q.Question.closeQuestionFromOwner(
                    widget._question,
                    widget._comment,
                  );
                  Navigator.of(context).pop();

                  widget._rebuild();
                } catch (err) {}
              },
              child: Text("Is This the Solution ?"),
            ),
          if (widget._question['solvedComment'] != null &&
              widget._question['solvedComment'] == widget._comment.id)
            Text(
              "Best Solution",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.green,
                  ),
            ),
          ListTile(
            dense: true,
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(widget._comment['userProfileImage']),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(widget._comment['userFullName']),
            subtitle: Text(widget._comment['date'].toString().substring(0, 16)),
            // trailing: SizedBox(
            //   width: 100,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButton(
            //           onPressed: () {
            //             setState(() {
            //               _vote = "up";
            //             });
            //           },
            //           icon: Icon(
            //             Icons.arrow_circle_up,
            //             color: _vote == "up" ? Colors.blue : Colors.black,
            //             size: 30,
            //           )),
            //       IconButton(
            //         onPressed: () {
            //           setState(() {
            //             _vote = "down";
            //           });
            //         },
            //         icon: Icon(
            //           Icons.arrow_circle_down,
            //           color: _vote == "down" ? Colors.blue : Colors.black,
            //           size: 30,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(widget._comment['comment']),
          ),
          Column(
            children: List.generate(
              widget._comment['images'].length,
              (index) => Container(
                child: InkWell(
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget._comment['images'][index]),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return Dialog(
                          //scrollable: true,
                          backgroundColor: Colors.transparent,
                          //titlePadding: EdgeInsets.zero,
                          //insetPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: InteractiveViewer(
                            //boundaryMargin: const EdgeInsets.all(20),

                            child: Image(
                              image: NetworkImage(
                                widget._comment['images'][index],
                              ),
                            ),
                          ),
                        ); //Create item
                      }),
                    );
                  },
                ),
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //   fit: BoxFit.fill,
                  //   image: NetworkImage(widget._comment['images'][index]),
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
