import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/widgets/question.dart';
import 'dart:developer';

class HomeQuestions extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _data;
  final Function _rebuild;
  HomeQuestions(this._data,this._rebuild);

  @override
  State<HomeQuestions> createState() => _HomeQuestionsState();
}

class _HomeQuestionsState extends State<HomeQuestions> {
  String? _search = "";
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _filter;


  @override
  void didChangeDependencies() {
    log("yes");
    _filter = widget._data;
    super.didChangeDependencies();
  }

  void _filterBySearch() {
    if (_search == "") {
      setState(() {
        _filter = widget._data;
      });
      return;
    }
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> newFilter = [];
    _filter!.forEach((element) {
      if (element['questionTitle']
              .toString()
              .toLowerCase()
              .contains(_search!.toLowerCase()) ||
          element['description']
              .toString()
              .toLowerCase()
              .contains(_search!.toLowerCase())) {
        newFilter.add(element);
      }
    });
    setState(() {
      _filter = newFilter;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search....",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
            onChanged: (value) {
              _search = value;
              _filterBySearch();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: _filter!.length,
            itemBuilder: (context, index) => QuestionComponent(
              _filter![index],
              false,
              widget._rebuild
            ),
          ),
        ],
      ),
    );
  }
}
