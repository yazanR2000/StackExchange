import 'package:flutter/material.dart';
import '../models/stackoverflow.dart';
import 'package:url_launcher/url_launcher.dart';

class StackOverflowScreen extends StatefulWidget {
  StackOverflowScreen({super.key});

  @override
  State<StackOverflowScreen> createState() => _StackOverflowScreenState();
}

class _StackOverflowScreenState extends State<StackOverflowScreen> {
  TextEditingController _search = TextEditingController();

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StackOverflow"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: "Search....",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: StackoverflowAPI.getSearchResults(_search.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<Map<String, dynamic>> results =
                    StackoverflowAPI.results;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        await _launchUrl(results[index]['link']);
                      },
                      leading: CircleAvatar(
                        // backgroundImage: NetworkImage(
                        //   results[index]['owner_profile_image'],
                        // ),
                      ),
                      title: Text("title"),
                      subtitle: Text("link"),
                      trailing: Icon(Icons.check_circle),
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
