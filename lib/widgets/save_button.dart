import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as u;

class SaveButton extends StatefulWidget {
  final QueryDocumentSnapshot _question;
  final bool _isFromSaves;
  SaveButton(this._question, this._isFromSaves);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool? _isSaved;
  @override
  void initState() {
    _isSaved = widget._isFromSaves;
    super.initState();
  }

  final u.User _user = u.User.getInstance();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        setState(() {
          _isSaved = !_isSaved!;
        });
        await _user.addToFavorite(widget._question, _isSaved!);
      },
      icon: Icon(
        _isSaved! ? Icons.bookmark : Icons.bookmark_border,
        color: _isSaved! ? Colors.amber : null,
      ),
    );
  }
}
