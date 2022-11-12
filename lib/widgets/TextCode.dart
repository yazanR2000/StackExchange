import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:http/http.dart';

class TextCode extends StatelessWidget {
  TextCode({super.key, this.textCode});
  String? textCode;
  static String? type;
  static String? textCodeEditor;
  static Syntax _getSyntax() {
    switch (type) {
      case "Flutter":
        {
          return Syntax.DART;
        }
      case "C++":
        {
          return Syntax.CPP;
        }
      case "Java":
        {
          return Syntax.JAVA;
        }
      case "C#":
        {
          return Syntax.CPP;
        }
      case "IOS":
        {
          return Syntax.SWIFT;
        }
      case "Desktop":
        {
          return Syntax.C;
        }
      case "React native":
        {
          return Syntax.JAVASCRIPT;
        }
      case "Others":
        {
          return Syntax.DART;
        }
    }
    return Syntax.C;
  }

  final syntaxViews = {
    "vscodeLight": SyntaxView(
      code: textCodeEditor!,
      syntax: _getSyntax(),
      syntaxTheme: SyntaxTheme.vscodeDark(),
      fontSize: 10.0,
      withZoom: true,
      withLinesCount: true,
      expanded: true,
    )
  };
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        //padding: const EdgeInsets.all(8),
        itemCount: syntaxViews.length,
        itemBuilder: (BuildContext context, int index) {
          String themeName = syntaxViews.keys.elementAt(index);
          SyntaxView syntaxView = syntaxViews.values.elementAt(index);
          return Card(
            //margin: const EdgeInsets.all(10),
            elevation: 3,
            child: Column(
              children: [
                //Divider(),
                if (syntaxView.expanded)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: syntaxView,
                  )
                else
                  syntaxView
              ],
            ),
          );
        });
  }
}
