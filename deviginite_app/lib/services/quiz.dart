import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer';

class QuizServices {
  static Future<List<String>> getQuiz(isAdult) async {
    try {
      var response = await http.post(
        Uri.parse("https://devignite.vercel.app/api/quiz"),
        body: jsonEncode({"isAdult": isAdult}),
        headers: {"Content-Type": "application/json"},
      );

      var data = await response.body;

      final data1 = jsonDecode(data);
      if (data1["success"]) {
        // Map<String, List<String>> data = jsonDecode(data);
        print("datataaa");

        List<String> listOfQuestions = [];

        for (var entry in data1['random_quiz_questions'].entries) {
          var key = entry.key;
          print("s");
          // print(data1['random_quiz_questions'][key]);
          data1['random_quiz_questions'][key].forEach((e) {
            print(e);
            print('dd');
            listOfQuestions.add(e);
          });
        }
        print(listOfQuestions);
        return listOfQuestions;
      } else {
        return [];
        print("no data from the backend!");
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> fetchMessage(String message) async {
    // Define the endpoint URL
    final String endpoint = 'http://192.168.0.106:8080/ai/';

    try {
      print("body is  " + message);
      final response = await http.post(Uri.parse(endpoint),
          headers: {'Content-Type': 'application/json'}, body: message);

      if (response.statusCode == 200) {
        // Decode the response JSON

        // Get the text message from the response
        String? textMessage = response.body;

        // Return the text message
        return textMessage;
      } else {
        // If the request was not successful, print the error status code
        print('Failed with status code: ${response.statusCode}');
        return "fail";
      }
    } catch (e) {
      // If an exception occurs, print the error
      print('Exception occurred: $e');
      return "fail";
    }
  }

  static Future<String> getRoute(String message) async {
    // Define the endpoint URL
    final String endpoint = 'http://192.168.0.106:8080/ai/getRoute';

    try {
      final response = await http.post(Uri.parse(endpoint), body: message);
      if (response.statusCode == 200) {
        // Decode the response JSON
        // Get the text message from the response
        String? textMessage = response.body;
        // Return the text message
        return textMessage;
      } else {
        // If the request was not successful, print the error status code
        print('Failed with status code: ${response.statusCode}');
        return "fail";
      }
    } catch (e) {
      // If an exception occurs, print the error
      print('Exception occurred: $e');
      return "fail";
    }
  }
}
