// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   TextEditingController fullnameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   GlobalKey<FormState> myFormKey = GlobalKey();
//   File? _image;
//   Future getImage() async {
//     final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );
//     if (image == null) return;
//     final imageTemporary = File(image.path);
//     setState(() {
//       this._image = imageTemporary;
//     });
//   }

//   DocumentSnapshot? _userData;

//   Future _getUserInfo(String userId) async {
//     try {
//       _userData = await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(userId)
//           .get();
//     } catch (err) {
//       print(err.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userId = ModalRoute.of(context)!.settings.arguments as String;
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return FutureBuilder(
//           future: _getUserInfo(userId),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return Container(
//               color: Color.fromARGB(255, 44, 46, 48),
//               child: SingleChildScrollView(
//                 keyboardDismissBehavior:
//                     ScrollViewKeyboardDismissBehavior.onDrag,
//                 child: Column(children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: TextFormField(
//                       keyboardType: TextInputType.name,
//                       textInputAction: TextInputAction.next,
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Username',
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       textInputAction: TextInputAction.next,
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Phone number',
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(
//                       "New profile image",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     onTap: () async {
//                       await getImage();
//                     },
//                     // dense: true,
//                     trailing: Icon(
//                       Icons.upload_outlined,
//                       size: 40,
//                     ),
//                   ),
//                   _image != null
//                       ? Image.file(
//                           _image!,
//                           width: 150,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.network(
//                           _userData!['User image'],
//                           width: 150,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text('Done'),
//                   )
//                 ]),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
