import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:http/http.dart';

class TextCode extends StatelessWidget {
  TextCode({super.key, this.textCode});
  String? textCode;
  static String? textCodeEditor;
  final syntaxViews = {
    "vscodeDark": SyntaxView(
      code: textCodeEditor!,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.vscodeDark(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
      expanded: false,
    ),
    "vscodeLight": SyntaxView(
        code: textCodeEditor!,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeLight(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: true)
  };
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: syntaxViews.length,
        itemBuilder: (BuildContext context, int index) {
          String themeName = syntaxViews.keys.elementAt(index);
          SyntaxView syntaxView = syntaxViews.values.elementAt(index);
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 6.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.brush_sharp),
                      Text(
                        themeName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.brush_sharp),
                    ],
                  ),
                ),
                Divider(),
                if (syntaxView.expanded)
                  Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: syntaxView)
                else
                  syntaxView
              ],
            ),
          );
        });
  }
}
