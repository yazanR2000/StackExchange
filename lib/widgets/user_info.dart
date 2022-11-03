import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String _imageUrl, _fullName;
  UserInfo(this._fullName, this._imageUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //contentPadding: EdgeInsets.zero,
      leading: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: ((context) {
              return Dialog(
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: InteractiveViewer(
                  child: Image(
                    height: double.infinity,
                    image: NetworkImage(_imageUrl),
                  ),
                ),
              ); //Create item
            }),
          );
        },
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(_imageUrl),
        ),
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
