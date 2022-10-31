import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;
import '../models/question.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key});
  // final String? description;
  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final List<XFile> images = [];
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

  final TextEditingController _solutionController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final String qId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add solution"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () async {
                      try {
                        setState(() {
                          _isLoading = !_isLoading;
                        });
                        await Question.addNewComment(
                          {
                            "comment": _solutionController.text,
                            "images": images,
                          },
                          qId,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Comment Added Successfully",
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      } catch (err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              err.toString(),
                            ),
                          ),
                        );
                      }
                      setState(() {
                        _isLoading = !_isLoading;
                      });
                    },
                    child: const Text("Done"),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _solutionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your solution'),
              ),
            ),
            Column(
              children: List.generate(images.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        i.File(images[index].path),
                      ),
                    ),
                  ),
                );
              }),
            ),
            // ListView.builder(

            //     itemCount: images.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.symmetric(vertical: 10),
            //         height: 200,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: FileImage(
            //               i.File(images[index].path),
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await pickImage();
                      },
                      child: Text('Add images'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
