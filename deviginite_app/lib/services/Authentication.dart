import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deviginite_app/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class Authentication {
  static Future<bool> registerUser(
      name, email, phone, password, bloodGrp) async {
    print("Called");
    Map<String, String>? location = await getLocation();
    log(name: "this is the location: ", location.toString());
    if (location != null) {
      log(name: "something", location.toString());
      var response = await http.post(
        Uri.parse(
          "${AppConstants.IP}/registerUser",
        ),
        body: jsonEncode(
          {
            "userName": name,
            "userEmail": email,
            "userPhone": "+91" + phone,
            "userPassword": password,
            "latitude": location['latitude'],
            "longitude": location['longitude'],
            "bloodGroup": bloodGrp,
          },
        ),
        headers: {"Content-Type": "application/json"},
      );

      var data = await response.body;
      final result = jsonDecode(data);
      print(result);
      var mess = result["data"];
      print("mess" + mess);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);
      await prefs.setString('userPhone', phone);
      await prefs.setString('userPassword', password);
      await prefs.setString('userLat', location['latitude']!);
      await prefs.setString('userLat', location['longitude']!);
      await prefs.setBool("isLoggedIn", true);

      if (mess == "ok") {
        Fluttertoast.showToast(
          msg: "Your Account has been created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', email);
        await prefs.setString('userPhone', phone);
        await prefs.setString('userPassword', password);

        return true;
      } else {
        Fluttertoast.showToast(
          msg: mess.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return false;
      }
    } else {
      throw "Not registring the user!";
    }
  }

  static Future<Map<String, String>> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log("Latitude = ${currentPosition.latitude.toString()}");
      log("Logitute=${currentPosition.longitude.toString()}");
      String latitude = currentPosition.latitude.toString();
      String longitude = currentPosition.longitude.toString();
      return {'latitude': latitude, 'longitude': longitude};
    }
    throw "what the fuck !";
  }

  static Future<bool> loginUser(email, password) async {
    print("Called");

    var response = await http.post(
      Uri.parse(
        "${AppConstants.IP}/loginUser",
      ),
      body: jsonEncode(
        {"userEmail": email, "userPassword": password},
      ),
      headers: {"Content-Type": "application/json"},
    );

    var data = await response.body;
    final result = jsonDecode(data);
    print(result);
    var mess = result["user"];

    if (mess != "fail") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', mess["_id"]);
      await prefs.setString('userEmail', mess["userEmail"]);
      await prefs.setString('userPhone', mess["userPhone"]);
      await prefs.setString('userPassword', mess["userPassword"]);
      await prefs.setBool("isLoggedIn", true);

      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Invalid Email/Password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      var data = await response.body;
      final result = jsonDecode(data);
      print(result);
      var mess = result["user"];

      if (mess != "fail") {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', mess["_id"]);
        await prefs.setString('userEmail', mess["userEmail"]);
        await prefs.setString('userPhone', mess["userPhone"]);
        await prefs.setString('userPassword', mess["userPassword"]);

        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Invalid Email/Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return false;
      }

      // Rest of your code...
    }
  }
}
