// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../widgets/question.dart';
// import '../models/question.dart' as q;
// import '../models/user.dart' as u;

// class MyQuestions extends StatefulWidget {
//   MyQuestions({super.key});

//   @override
//   State<MyQuestions> createState() => _MyQuestionsState();
// }

// class _MyQuestionsState extends State<MyQuestions> {
//   final uid = FirebaseAuth.instance.currentUser!.uid;
//   void _rebuild() {
//     setState(() {});
//   }

//   final u.User _user = u.User.getInstance();
//   final List<DocumentSnapshot> _saves = [];
//   Future _getSaves() async {
//     final List<String> _questions = _user.userData['saves'];
//     Future.wait(
//       _questions.map((e) async {
//         final DocumentSnapshot question = await FirebaseFirestore.instance
//             .collection("Questions")
//             .doc(e)
//             .get();
//           _saves.add(question);
//       }),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Saves"),
//       ),
//       body: FutureBuilder(
//         future: _getSaves(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (!snapshot.hasData) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("You didn't add any quetion"),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pushNamed('/add_new_question');
//                   },
//                   child: Text("Post a question"),
//                 ),
//               ],
//             );
//           }
          
//           return ListView.builder(
//             padding: const EdgeInsets.all(15),
//             //reverse: true,
//             itemCount: _saves.length,
//             itemBuilder: (context, index) {
//               return QuestionComponent(data[index], false, _rebuild);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
