import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stackexchange/providers.dart/profile_provider.dart';
import 'package:stackexchange/widgets/user_info.dart';
import 'package:stackexchange/widgets/user_problems.dart';
// import '../widgets/user_info.dart';
import '../widgets/edit_profile.dart';
import '../widgets/user_statistic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' as i;
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot? _userData;

  Future _getUserInfo(String userId) async {
    try {
      _userData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();
    } catch (err) {
      print(err.toString());
    }
  }

  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> myFormKey = GlobalKey();
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

  bool changeNum = false;
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: const Color(0xff2f3b47),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (p0, constraints) => Scaffold(
                //backgroundColor: const Color(0xff2f3b47),
                body: FutureBuilder(
                  future: _getUserInfo(userId),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      //padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            // title: Text(
                            //   _userData!['Full name'],
                            //   style: const TextStyle(color: Colors.white),
                            // ),
                            leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            trailing:
                                userId == FirebaseAuth.instance.currentUser!.uid
                                    ? IconButton(
                                        onPressed: (() {
                                          showModalBottomSheet(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(25.0),
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              builder: (BuildContext context) {
                                                return DraggableScrollableSheet(
                                                    initialChildSize:
                                                        0.75, //set this as you want
                                                    maxChildSize:
                                                        0.75, //set this as you want
                                                    minChildSize:
                                                        0.75, //set this as you want
                                                    expand: false,
                                                    builder: (context,
                                                        scrollController) {
                                                      return Container(
                                                        color: Color.fromARGB(
                                                            255, 44, 46, 48),
                                                        child:
                                                            SingleChildScrollView(
                                                                keyboardDismissBehavior:
                                                                    ScrollViewKeyboardDismissBehavior
                                                                        .onDrag,
                                                                child: Column(
                                                                    children: [
                                                                      Consumer<
                                                                          ProfileProvider>(
                                                                        builder: (context,
                                                                            p,
                                                                            _) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: fullnameController,
                                                                              keyboardType: TextInputType.name,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                hintText: '${p.isChange.isEmpty ? _userData!['Full name'] : p.isChange}',
                                                                                labelText: 'Username',
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                      Consumer<
                                                                          ProfileProvider>(
                                                                        builder: (context,
                                                                            p,
                                                                            _) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: phoneNumberController,
                                                                              keyboardType: TextInputType.phone,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                hintText: _userData!['Phone number'],
                                                                                labelText: 'Phone number',
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                      ListTile(
                                                                        title:
                                                                            Text(
                                                                          "New profile image",
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          await getImage();
                                                                        },
                                                                        // dense: true,
                                                                        trailing:
                                                                            Icon(
                                                                          Icons
                                                                              .upload_outlined,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      _image !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              _image!,
                                                                              width: 150,
                                                                              height: 150,
                                                                              fit: BoxFit.cover,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              _userData!['User image'],
                                                                              width: 150,
                                                                              height: 150,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                      SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          final userId = FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid;
                                                                          FirebaseStorage
                                                                              storage =
                                                                              FirebaseStorage.instance;
                                                                          Reference ref = storage
                                                                              .ref()
                                                                              .child("Users")
                                                                              .child(userId);
                                                                          String?
                                                                              imageUrl;
                                                                          if (_userData!['image']
                                                                              .isNotEmpty) {
                                                                            await ref.putFile(i.File(_userData!['image']));
                                                                            imageUrl =
                                                                                await ref.getDownloadURL();
                                                                          }
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection('Users')
                                                                              .doc(userId)
                                                                              .update({
                                                                            "User image": _image == null
                                                                                ? _userData!['User image']
                                                                                : imageUrl,
                                                                            'Full name': fullnameController.text == ''
                                                                                ? _userData!['Full name']
                                                                                : fullnameController.text,
                                                                            'Phone number': phoneNumberController.text == ''
                                                                                ? _userData!['Phone number']
                                                                                : phoneNumberController.text,
                                                                          });

                                                                          Provider.of<ProfileProvider>(context, listen: false).isChange =
                                                                              fullnameController.text;

                                                                          phoneNumberController
                                                                              .clear();
                                                                          fullnameController
                                                                              .clear();
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'Done'),
                                                                      )
                                                                    ])),
                                                      ); //whatever you're returning, does not have to be a Container
                                                    });
                                              });
                                        }),
                                        icon: Icon(Icons.settings_outlined))
                                    : TextButton(
                                        child: Text(
                                          "Contact",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () async {
                                          final Uri Phone_url = Uri.parse(
                                              'tel:${_userData!['Phone number']}');

                                          Future<void> PhoneCall() async {
                                            if (!await launchUrl(Phone_url)) {
                                              throw 'Could not launch $Phone_url';
                                            }
                                          }

                                          final Uri Email_url = Uri.parse(
                                              'mailto:${_userData!['User Email']}');

                                          Future<void> Email() async {
                                            if (!await launchUrl(Email_url)) {
                                              throw 'Could not launch $Email_url';
                                            }
                                          }

                                          await showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Row(
                                                  children: [
                                                    Text('Contact'),
                                                    SizedBox(
                                                      width: constraints
                                                              .maxHeight *
                                                          0.15,
                                                    ),
                                                  ],
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Consumer<ProfileProvider>(
                                                          builder:
                                                              (context, p, _) {
                                                        return ListTile(
                                                          onTap: PhoneCall,
                                                          dense: true,
                                                          leading:
                                                              Icon(Icons.call),
                                                          title: SelectableText(
                                                              _userData![
                                                                  'Phone number']),
                                                        );
                                                      }),
                                                      ListTile(
                                                        onTap: Email,
                                                        dense: true,
                                                        leading:
                                                            Icon(Icons.email),
                                                        title: SelectableText(
                                                            '${_userData!['User Email']}'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Back'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<ProfileProvider>(
                            builder: (context, p, _) {
                              return UserInformation(
                                '${p.isChange.isEmpty ? _userData!['Full name'] : p.isChange}',
                                _userData!['User image'],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          UserSatistic(
                            _userData!['questions'],
                            _userData!['solutions'],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 5,
                            height: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          UserProblems(userId, constraints),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
