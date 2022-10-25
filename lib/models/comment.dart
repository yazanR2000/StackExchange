class Comment {
  //update requests
  Future upVote() async {}
  Future downVote() async {}
  //only owner of question can access this method
  //Future closedComment() async {} // mean that this comment solve the problem
}

/*
(Structure on firestore)
Comments Collection
  QuestionId
    [CommentId]
      {
          "userId" : String,
          "userImage" : String,
          "date" : String,
          "comment" : String,
          "upVote" : number,
          "downVote" : number,
          "image" : [String],
      }
*/