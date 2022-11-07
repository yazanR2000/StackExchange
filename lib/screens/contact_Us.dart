import 'package:flutter/material.dart';

class Contact_Us extends StatefulWidget {
  const Contact_Us({super.key});

  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCont = TextEditingController();
    TextEditingController emailCont = TextEditingController();
    TextEditingController massegeCont = TextEditingController();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            backgroundColor: Color(0xff2f3b47),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(constraints.maxHeight * 0.03),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/logo-removebg.png",
                          height: constraints.maxHeight * 0.2),
                      Text(
                        "CONTACT US",
                        style: TextStyle(
                            fontSize: constraints.maxHeight * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        // validator: ,
                        controller: nameCont,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Name",
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: emailCont,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: massegeCont,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          isDense: true, // important line
                          contentPadding: EdgeInsets.fromLTRB(10, 70, 20, 70),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Massege",
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(constraints.maxHeight * 0.2,
                                  constraints.maxHeight * 0.05)),
                          onPressed: () async {
                            nameCont.clear();
                            emailCont.clear();
                            massegeCont.clear();
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
