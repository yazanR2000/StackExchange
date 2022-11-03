import 'package:flutter/material.dart';
import '../models/stackoverflow.dart';

class StackOverflowScreen extends StatefulWidget {
  StackOverflowScreen({super.key});

  @override
  State<StackOverflowScreen> createState() => _StackOverflowScreenState();
}

class _StackOverflowScreenState extends State<StackOverflowScreen> {
  TextEditingController _search = TextEditingController();

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
            SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder(
                future: StackoverflowAPI.getSearchResults(_search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<Map<String,dynamic>> results = StackoverflowAPI.results;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(),
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
            ),
          ],
        ),
      ),
    );
  }
}
