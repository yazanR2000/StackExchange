import 'package:http/http.dart' as http;
import 'dart:convert';
import "dart:developer";
class StackoverflowAPI {
  static List<Map<String, dynamic>> _results = [];

  static List<Map<String, dynamic>> get results => _results;

  static const _baseUrl = "https://api.stackexchange.com";

  static Future getSearchResults(String search) async {
    _results.clear();
    try {
      final response = await http.get(
        Uri.parse(
            "$_baseUrl/2.3/search/advanced?order=desc&title=$search&sort=votes&site=stackoverflow"),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      //log("$data");
      data['items'].forEach((element) {
        Map<String, dynamic> item = {};
        item.putIfAbsent(
            "owner_profile_image",
            () => element["owner"]["profile_image"] == null
                ? "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png"
                : element["owner"]["profile_image"]);
        item.putIfAbsent(
            "is_answered",
            () => element["is_answered"] == false
                ? false
                : element["is_answered"]);
        item.putIfAbsent("answer_count", () => element["answer_count"]);
        item.putIfAbsent("title", () => element["title"] == null ? "Empty" : element["title"]);
        item.putIfAbsent("link", () => element["link"] == null ? "" : element["link"]);
        item.forEach((key, value) {
          if(value == null){
            log("yes");
          }
        });
        _results.add(item);
      });
      //log("$_results");
    } catch (err) {
      throw err;
    }
  }
}
