import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as u;
class SaveButton extends StatefulWidget {
  final String _questionId;
  SaveButton(this._questionId);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _isSaved = false;
  final u.User _user = u.User.getInstance();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        setState(() {
          _isSaved = !_isSaved;
        });
        //await _user.addToFavorite(widget._questionId, _isSaved);
      },
      icon: Icon(
        _isSaved ? Icons.bookmark : Icons.bookmark_border,
      ),
    );
  }
}
