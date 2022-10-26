import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({required this.isContainedImage, super.key});
  final bool? isContainedImage;
  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  bool up = false;
  bool down = false;
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
            subtitle: Text('10/2/2022'),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          up = !up;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_circle_up,
                        color: up ? Colors.blue : Colors.black,
                        size: 30,
                      )),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        down = !down;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_circle_down,
                      color: down ? Colors.blue : Colors.black,
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
          if (widget.isContainedImage!) ListView(children: [Image.network("")])
        ],
      ),
    );
  }
}
