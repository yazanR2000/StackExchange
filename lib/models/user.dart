//Singelton class
import './question.dart';

class User {
  static final User _user = User();
  User() {}
  static User getInstance() => _user;

  String? _uid;
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  final List<Question> _myQuestions = [];
  Future getUserQuestions() async {}
  Future addNewQuestion(Map<String, dynamic> details) async {}
  
}

/*
(Structure on firestore)
User Collection 
  UserId
    {
      "Full name" : String,
      "Phone number" : Number,
      "Profile image" : String => "image url from storage",
      "Comments" : [commentsId]
    }
*/