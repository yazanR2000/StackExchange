import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String _imageUrl, _fullName;
  UserInfo(this._fullName, this._imageUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(_imageUrl),
      ),
      title: Text(
        _fullName,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
