import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stackexchange/widgets/Drawer.dart';
import '../widgets/question.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Questions").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.docs;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search....",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      QuestionComponent(data[index]),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add_new_question");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
