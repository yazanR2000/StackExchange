import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/Comment_component.dart';

class FullPost extends StatefulWidget {
  const FullPost({super.key});

  @override
  State<FullPost> createState() => _FullPostState();
}

class _FullPostState extends State<FullPost> {
  bool bookmark = false;

  final CollectionReference Comments =
      FirebaseFirestore.instance.collection('Comments');
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
    final question =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${question['userFullName'].toString().split(' ')[0]}'s questions"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Text(question['userFullName'].toString()),
                  subtitle: Text(question['date'].toString().substring(0, 16)),
                  trailing: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Chip(
                          backgroundColor: Color(0xff),
                          label: Text(
                            question['type'],
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (_isNew(DateTime.parse(question['date'])))
                          const Chip(
                            label: Text(
                              "new",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
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
                  question['questionTitle'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    question['description'],
                  ),
                ),
                Column(
                  children: List.generate(
                    question['images'].length,
                    (index) => Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(question['images'][index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Text(
            "Comments",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream:
                  Comments.doc(question.id).collection('Comments').snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (streamSnapshot.hasData) {
                  final data = streamSnapshot.data!.docs;
                  if (data.length == 0) {
                    return const Center(
                      child: Text("There's no comments"),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    padding: EdgeInsets.only(bottom: 50),
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return CommentComponent(data[index]);
                    }),
                  );
                }
                return const Center(
                  child: Text("There's no comments"),
                );
              })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/CommentSheet',
            arguments: question.id,
          );
        },
        label: Row(
          children: [
            Icon(Icons.add),
            Text("Add Comment"),
          ],
        ),
      ),
    );
  }
}
