import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer';

class Quiz {
  static Future<dynamic> getQuiz(isAdult) async {
    try {
      var response = await http.post(
        Uri.parse("https://devignite.vercel.app/api/quiz"),
        body: jsonEncode({"isAdult": isAdult}),
        headers: {"Content-Type": "application/json"},
      );

      var data = await response.body;
      print("this is the data! : " + data);
      final success = jsonDecode(data);
      if (success["success"]) {
        print("this is the json: " + success.toString());
        return success;
      } else {
        print("no data from the backend!");
      }
    } catch (e) {
      print(e);
    }
  }
}
