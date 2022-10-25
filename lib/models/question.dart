import './comment.dart';

class Question {
  final List<Comment> _comments = [];
  List<Comment> get comment => _comments;
  //get request
  Future fetchComments() async {}

  //only owner of the question can access these three methods
  Future deleteQuestionFromOwner() async {}
  Future closeQuestionFromOwner(String commentId) async {}
  Future editQuestionFromOwner() async {}
}

/*
(Structure on firestore)
Questions Collection
  QuestionId
    {
      "type" : "flutter",
      "userId" : String,
      "userImage" : String,
      "questionTitle" : String ({80 - 100}) => "we will user this for searching",
      "description" : String,
      "image" : [String],
      "date" : String => We will use this to check if it's new or not
      "isClosed" : bool,
      "ifIsClosed" : String => "Comment id - the comment that closed this question",
    }
*/
