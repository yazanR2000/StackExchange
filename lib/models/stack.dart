//Singelton class
import 'package:cloud_firestore/cloud_firestore.dart';

import './question.dart';
class Stack {
  static final Stack _stack = Stack();
  Stack(){}
  static Stack getInstance() => _stack;

  final List<Question> _questions = [];
  List<Question> get questions => _questions;
  //get request
   void addQuestions(List<QueryDocumentSnapshot<Map<String, dynamic>>> products) {
    _questions.clear();
    products.forEach((element) {
      _questions.add(
        Question(element),
      );
    });
  }
}

