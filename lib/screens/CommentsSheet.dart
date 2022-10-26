import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key});
  // final String? description;
  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final List<XFile?> images = [];
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your solution'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            i.File(images[index]!.path),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await pickImage();
                  },
                  child: Text('Add images'),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    label: Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
