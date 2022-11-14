import 'package:flutter/material.dart';
import '../models/stackoverflow.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/waiting_questions.dart';

class StackOverflowScreen extends StatefulWidget {
  StackOverflowScreen({super.key});

  @override
  State<StackOverflowScreen> createState() => _StackOverflowScreenState();
}

class _StackOverflowScreenState extends State<StackOverflowScreen> {
  TextEditingController _search = TextEditingController();

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stackoverflow"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search....",
                  suffixIcon: IconButton(
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: (() {
                        Navigator.pushNamed(context, '/image_Too_text');
                      })),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: _search.text.isEmpty
                  ? Future.delayed(
                      Duration(seconds: 0),
                    )
                  : _search.text.isEmpty
                      ? Future.delayed(
                          Duration(seconds: 0),
                        )
                      : StackoverflowAPI.getSearchResults(_search.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(height: 800, child: ShimmerWaiting());
                }
                final List<Map<String, dynamic>> results =
                    StackoverflowAPI.results;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      dense: true,
                      autofocus: true,
                      onTap: () async {
                        await _launchUrl(results[index]['link']);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          results[index]['owner_profile_image'],
                        ),
                      ),
                      title: Text(results[index]['title'].toString()),
                      subtitle: Text(results[index]['link'].toString()),
                      trailing: results[index]['is_answered'] == true
                          ? Chip(
                              //padding: EdgeInsets.zero,
                              label: Text(
                                "Solved",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                ),
                              ),
                              backgroundColor: Colors.green.withOpacity(0.3),
                            )
                          : SizedBox(),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: results.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
