import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  String _isChange = "";

  String get isChange => _isChange;

  set isChange(String value) {
    _isChange = value;
    notifyListeners();
  }

  String _isChange2 = "";

  String get isChange2 => _isChange2;

  set isChange2(String value) {
    _isChange2 = value;
    notifyListeners();
  }

  String _isChange3 = "";

  String get isChange3 => _isChange3;

  set isChange3(String value) {
    _isChange3 = value;
    notifyListeners();
  }
}

// class UserPhoneNumberProvider with ChangeNotifier {
//   String _isChange = "";

//   String get isChange => _isChange;

//   set isChange(String value) {
//     _isChange = value;
//     notifyListeners();
//   }
// }

// class UserImageProvider with ChangeNotifier {
//   String _isChange = "";

//   String get isChange => _isChange;

//   set isChange(String value) {
//     _isChange = value;
//     notifyListeners();
//   }
// }
