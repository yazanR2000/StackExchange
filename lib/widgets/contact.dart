import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, this.name, this.email, this.Message});

  final String? name;
  final String? email;
  final String? Message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("$name"),
          SizedBox(
            height: 5,
          ),
          Text("$email"),
          SizedBox(
            height: 5,
          ),
          Text("$Message")
        ],
      ),
    );
  }
}
