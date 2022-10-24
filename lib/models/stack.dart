//Singelton class
import './question.dart';
class Stack {
  static final Stack _stack = Stack();
  Stack(){}
  static Stack getInstance() => _stack;

  final List<Question> _questions = [];
  List<Question> get questions => _questions;
  //get request
  Future fetchQuestions() async {}
}

