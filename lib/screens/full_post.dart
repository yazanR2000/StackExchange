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

  @override
  Widget build(BuildContext context) {
    final question =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(20),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Text("ahmad"),
                  subtitle: Text(question['date'].toString().substring(0, 10)),
                  trailing: FittedBox(
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
                Column(
                  children: List.generate(
                    question['images'].length,
                    (index) => Container(
                      height: 200,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(question['images'][index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return CommentComponent();
                    }),
                  );
                }
                return const Center(
                  child: Text("There's no comments"),
                );
              })
        ],
      ),
    );
  }
}