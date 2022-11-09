import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  String _isChange = "";

  String get isChange => _isChange;

  set isChange(String value) {
    _isChange = value;
    notifyListeners();
  }
}
