import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stackexchange/widgets/contact.dart';
import '../../models/user.dart' as u;

class GetContact extends StatefulWidget {
  const GetContact({super.key});

  @override
  State<GetContact> createState() => _GetContactState();
}

class _GetContactState extends State<GetContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Color(0xff2f3b47),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Contact Us").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                final data = snapshot.data!.docs;

                return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: Column(
                      children: [
                        Center(child: Text(data[index]["Full name"])),
                        SizedBox(height: 10),
                        Container(child: Text(data[index]["User Email"])),
                        SizedBox(height: 10),
                        Container(child: Text(data[index]["message"])),
                      ],
                    ));
                  },
                );
                // return ContactWidget(
                //   name: name,
                // );
              }
              return Text("There is no data");
            }));
  }
}
