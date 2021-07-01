import 'dart:convert';
import 'package:rich_oak_fintech/settings.dart' as settings;

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenSerializer {
  final String refreshToken;
  final String accessToken;

  TokenSerializer({required this.refreshToken, required this.accessToken});

  factory TokenSerializer.json(Map<String, dynamic> signUpDict) {
    String refreshToken = signUpDict["refresh"];
    String accessToken = signUpDict["access"];
    return TokenSerializer(
        refreshToken: refreshToken, accessToken: accessToken);
  }
}

class SignUpSerializer {
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final String? id;

  SignUpSerializer(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.password,
      this.id});

  factory SignUpSerializer.json(Map<String, dynamic> signUpDict) {
    String firstName = signUpDict["first_name"];
    String lastName = signUpDict["last_name"];
    String email = signUpDict["email"];
    // String password = signUpDict["password"];
    String id = signUpDict["id"];
    return SignUpSerializer(
        firstName: firstName,
        lastName: lastName,
        email: email,
        // password: password,
        id: id);
  }

  Future<bool> savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("first_name", firstName);
    prefs.setString("last_name", lastName);
    prefs.setString("email", email);
    prefs.setString("id", id!);
    return true;
  }
}

class SignInSerializer {
  final String email;
  final String password;

  SignInSerializer({required this.email, required this.password});

  factory SignInSerializer.json(Map<String, dynamic> signUpDict) {
    String email = signUpDict["email"];
    String password = signUpDict["password"];
    return SignInSerializer(email: email, password: password);
  }
}

Future<void> getNextPage() async {
  // String domain = settings.DOMAIN_NAME;
  // var url = Uri.parse(domain + "/user/");
  // Map headers = {"content-type": "application/json"};
  Map res = {
    "access": "4639307",
    "refresh": "37595303",
    "user": {
      "first_name": "Chidi",
      "last_name": "Nnadi",
      "id": "2",
      "email": "chidi@gmail.com"
    }
  };
  // Simulate Post
  final response = await Future.delayed(Duration(seconds: 1), () => res);
  if (!response.containsKey("access")) {
    print("has no token");
  } else {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", response["access"]);
    prefs.setString("refresh_token", response["refresh"]);
    SignUpSerializer signUpInst = SignUpSerializer.json(response["user"]);
  }
}
