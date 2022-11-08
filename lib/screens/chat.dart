import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final mssageTextcontroller = TextEditingController();
  String? messageText; //this give us the message
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        print(signInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  String? docId;

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamed('/NotificationsScreen');
          //   },
          //   icon: Icon(
          //     Icons.notifications,
          //   ),
          // )
        ],
        title: Text(
          "Chat",
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //MessageStreamBulder(),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Chat").where(
                  'contacts', // ["y1","y2"]
                  arrayContainsAny: [
                    FirebaseAuth.instance.currentUser!.uid,
                    uid
                  ],
                ).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data!.docs;
                  return ListView.builder(
                    itemBuilder: (context, index) => Text("Yazan"),
                    itemCount: data.length,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: TextField(
                      controller: mssageTextcontroller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: "Write your message here...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (() {
                      mssageTextcontroller.clear();

                      // _firestore.collection("messages").add(
                      //   {
                      //     'text': messageText,
                      //     'sender': signInUser.email,
                      //     'time': FieldValue.serverTimestamp(),
                      //   },
                      // );
                    }),
                    child: Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

late User signInUser;

class MessageStreamBulder extends StatelessWidget {
  const MessageStreamBulder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .orderBy('time')
          .snapshots(),
      builder: ((context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          // add heere a spinner
          Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get("text");
          final messageSender = message.get("sender");
          final messageTime = message.get('time');
          final currentUser = signInUser.email;

          final messageWidget = MessageLine(
            time: messageTime.toString(),
            isME: currentUser == messageSender,
            sender: messageSender,
            text: messageText,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            children: messageWidgets,
          ),
        );
      }),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine(
      {super.key,
      this.text,
      required this.time,
      this.sender,
      required this.isME});
  final String? text;
  final String? sender;
  final bool isME;
  final String? time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text("$sender",
              style: TextStyle(fontSize: 12, color: Colors.yellow[900])),
          Material(
              elevation: 5,
              borderRadius: isME
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
              color: isME ? Colors.blue[800] : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                    style: TextStyle(
                      color: isME ? Colors.white : Colors.black54,
                      fontSize: 15,
                    ),
                    "$text ,  "),
              )),
        ],
      ),
    );
  }
}
