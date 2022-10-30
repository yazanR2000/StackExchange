import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/widgets/comments.dart';
import '../widgets/Comment_component.dart';

class FullPost extends StatefulWidget {
  const FullPost({super.key});

  @override
  State<FullPost> createState() => _FullPostState();
}

class _FullPostState extends State<FullPost> {
  bool bookmark = false;

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
    final details =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${details['question']['userFullName'].toString().split(' ')[0]}'s questions"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
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
                        details['question']['userImageUrl'],
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(details['question']['userFullName'].toString()),
                    subtitle: Text(details['question']['date']
                        .toString()
                        .substring(0, 16)),
                    trailing: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Chip(
                            backgroundColor: Color(0xff),
                            label: Text(
                              details['question']['type'],
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (_isNew(
                              DateTime.parse(details['question']['date'])))
                            const Chip(
                              label: Text(
                                "new",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
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
                    details['question']['questionTitle'],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      details['question']['description'],
                    ),
                  ),
                  Column(
                    children: List.generate(
                      details['question']['images'].length,
                      (index) => Container(
                        child: InkWell(
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                details['question']['images'][index]),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: ((context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: InteractiveViewer(
                                    //boundaryMargin: const EdgeInsets.all(20),
                                    child: Image(
                                      image: NetworkImage(
                                        details['question']['images'][index],
                                      ),
                                    ),
                                  ),
                                );
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
                          //   image: NetworkImage(
                          //       details['question']['images'][index]),
                          // ),
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
            Comments(details['question'], details['rebuild']),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/CommentSheet',
            arguments: details['question'].id,
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
