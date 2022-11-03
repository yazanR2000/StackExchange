import 'package:http/http.dart' as http;
import 'dart:convert';

class StackoverflowAPI {
  static List<Map<String, dynamic>> _results = [];

  static List<Map<String, dynamic>> get results => _results;

  static const _baseUrl = "https://api.stackexchange.com";

  static Future getSearchResults(String search) async {
    try {
      final response = await http.get(
        Uri.parse(
            "$_baseUrl/2.3/search/advanced?order=desc&title=$search&sort=votes&site=stackoverflow"),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      data['items'].forEach((element) {
        Map<String, dynamic> item = {};
        item.putIfAbsent(
            "owner_profile_image", () => element["owner"]["profile_image"]);
        item.putIfAbsent("is_answered", () => element["is_answered"]);
        item.putIfAbsent("answer_count", () => element["answer_count"]);
        item.putIfAbsent("title", () => element["title"]);
        item.putIfAbsent("link", () => element["link"]);
        _results.add(item);
      });
    } catch (err) {
      throw err;
    }
  }
}
