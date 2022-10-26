import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewPostComponent extends StatefulWidget {
  const AddNewPostComponent({super.key});

  @override
  State<AddNewPostComponent> createState() => _AddNewPostComponentState();
}

class _AddNewPostComponentState extends State<AddNewPostComponent> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("What is your issue?"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
            ),
          ],
        ),
      ),
    );
  }
}
