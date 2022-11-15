import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:stackexchange/providers.dart/profile_provider.dart';
import 'package:stackexchange/widgets/user_info.dart';
import 'package:stackexchange/widgets/user_problems.dart';
import '../widgets/user_statistic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  TextEditingController userEmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> myFormKey = GlobalKey();

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                //color: Colors.white,
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
                                                        color: Colors.white,
                                                        child:
                                                            SingleChildScrollView(
                                                                keyboardDismissBehavior:
                                                                    ScrollViewKeyboardDismissBehavior
                                                                        .onDrag,
                                                                child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            Text(
                                                                          "Edit Your Contact",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                                                                        ),
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
                                                                              controller: userEmailController,
                                                                              keyboardType: TextInputType.name,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                hintText: '${p.isChange.isEmpty ? _userData!['User Email'] : p.isChange}',
                                                                                labelText: 'Contact Email',
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
                                                                                hintText: '${p.isChange2.isEmpty ? _userData!['Phone number'] : p.isChange2}',
                                                                                labelText: 'Phone number',
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 60),
                                                                              child: ElevatedButton.icon(
                                                                                icon: Icon(Icons.edit_outlined),
                                                                                onPressed: () async {
                                                                                  await FirebaseFirestore.instance.collection('Users').doc(userId).update({
                                                                                    'User Email': userEmailController.text == '' ? _userData!['User Email'] : userEmailController.text,
                                                                                    'Phone number': phoneNumberController.text == '' ? _userData!['Phone number'] : phoneNumberController.text,
                                                                                  });

                                                                                  Provider.of<ProfileProvider>(context, listen: false).isChange = userEmailController.text;
                                                                                  Provider.of<ProfileProvider>(context, listen: false).isChange2 = phoneNumberController.text;

                                                                                  phoneNumberController.clear();
                                                                                  userEmailController.clear();
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                label: Text(
                                                                                  'Edit',
                                                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ])),
                                                      ); //whatever you're returning, does not have to be a Container
                                                    });
                                              });
                                        }),
                                        icon: Icon(Icons.edit_outlined))
                                    : TextButton(
                                        child: Text(
                                          "Contact Me",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(color: Colors.blue),
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
                                                    Text(
                                                      'Contact',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
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
                                                            p.isChange2.isEmpty
                                                                ? _userData![
                                                                    'Phone number']
                                                                : p.isChange2,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(),
                                                          ),
                                                        );
                                                      }),
                                                      Consumer<ProfileProvider>(
                                                          builder:
                                                              (context, p, _) {
                                                        return ListTile(
                                                          onTap: Email,
                                                          dense: true,
                                                          leading:
                                                              Icon(Icons.email),
                                                          title: SelectableText(
                                                            p.isChange.isEmpty
                                                                ? _userData![
                                                                    'User Email']
                                                                : p.isChange,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(),
                                                          ),
                                                        );
                                                      })
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
                          UserInformation(
                            _userData!['Full name'],
                            _userData!['User image'],
                            _userData!['solutions'],
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
