import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({super.key});

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  String? _vote;
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
              backgroundImage: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text("ahmad"),
            subtitle: Text('10/2/2022'),
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
            child: Text(
                'testestestestetsetsetsetsetestsetestfdgsfdgsfdgfdgdgfsdgfsdgfdgfgfdgfdgsfggfasdfasdfasfsdhughgyuguyyuyu87yughuhygwre98rtyushushgestestsetsetsetsetestestestsestestesteste'),
          ),
          
        ],
      ),
    );
  }
}
