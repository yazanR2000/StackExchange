import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stackexchange/widgets/question.dart';
import 'dart:developer';

class HomeQuestions extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _data;
  final Function _rebuild;
  HomeQuestions(this._data, this._rebuild);

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
              .contains(_search!.toLowerCase()) || element['type']
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
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                // prefix: IconButton(),
                hintText: "Search....",
                //suffix: Icon(Icons.search),
                suffixIcon: IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    onPressed: (() {
                      Navigator.pushNamed(context, '/image_Too_text');
                    })),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                _search = value;
                _filterBySearch();
              },
            ),
          ),
          ListView.separated(
            //reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              thickness: 5,
              height: 5,
              color: Colors.grey.shade100,
            ),
            itemCount: _filter!.length,
            itemBuilder: (context, index) => QuestionComponent(
                _filter![index], false, false, widget._rebuild),
          ),
        ],
      ),
    );
  }
}
