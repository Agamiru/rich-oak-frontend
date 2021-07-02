import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' as foundation;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:rich_oak_fintech/settings.dart' as settings;
import 'package:rich_oak_fintech/utils/utils.dart' as utils;

class TokenSerializer {
  final String refreshToken;
  final String accessToken;

  TokenSerializer({required this.refreshToken, required this.accessToken});

  factory TokenSerializer.json(Map<String, dynamic> tokenDict) {
    String refreshToken = tokenDict["refresh"];
    String accessToken = tokenDict["access"];
    return TokenSerializer(
        refreshToken: refreshToken, accessToken: accessToken);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "refresh": refreshToken, "access": accessToken,
    };
    return map;
  }
}

class UserSerializer {
  final String firstName;
  final String lastName;
  final String email;
  final int id;
  final int? bvn;

  static const userEndpoint = "${settings.DOMAIN_NAME}/user/";

  UserSerializer(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.id,
      this.bvn});

  factory UserSerializer.json(Map<String, dynamic> userDict) {
    String firstName = userDict["first_name"];
    String lastName = userDict["last_name"];
    String email = userDict["email"];
    int id = userDict["id"];
    int bvn = userDict["bvn"];

    return UserSerializer(
      firstName: firstName,
      lastName: lastName,
      email: email,
      id: id,
      bvn: bvn,
    );
  }

  factory UserSerializer.fromPrefs(SharedPreferences prefs) {
    String firstName = prefs.getString("first_name")!;
    String lastName = prefs.getString("last_name")!;
    String email = prefs.getString("email")!;
    int id = prefs.getInt("id")!;
    int? bvn = prefs.getInt("bvn");

    return UserSerializer(
      firstName: firstName,
      lastName: lastName,
      email: email,
      id: id,
      bvn: bvn,
    );
  }

  Map<String, dynamic> toMap({List<String>? exclude}) {
    Map<String, dynamic> map = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "id": id,
      "bvn": bvn
    };
    if (exclude != null) {
      for (String val in exclude) {
        if (map.containsKey(val)) {
          map.remove(val);
        }
      }
    }
    return map;
  }

  Future<utils.BoolData> getUser({List<String>? exclude}) async {
    // Http data
    Map httpBody = toMap(exclude: exclude);
    Uri url;
    if (foundation.kDebugMode) {
      url = Uri.parse("${settings.LOCAL_HOST}/user/");
    } else {
      url = Uri.parse(userEndpoint);
    }
    Map<String, dynamic>? respBody;
    // Make Request
    try {
      http.Response resp = await http.post(url,
          body: httpBody,
          headers: {"content-type": "application/x-www-form-urlencoded"});
      respBody = jsonDecode(resp.body);
      if (resp.statusCode == 201) {
        print("about to save prefs");
        savePrefs(respBody!);
        print("I Saved prefs");
        return utils.BoolData(status: true, data: respBody);
      } else {
        return utils.BoolData(status: false, data: respBody);
      }
    } catch (e) {
      return utils.BoolData(status: false, data: e);
    }
  }

  Future<void> savePrefs(Map<String, dynamic> respBody) async {
    UserSerializer userInst = UserSerializer.json(respBody);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", userInst.id);
    prefs.setString("first_name", userInst.firstName);
    prefs.setString("last_name", userInst.lastName);
    prefs.setString("email", userInst.email);
  }



  @override
  String toString() {
    return toMap().toString();
  }
}

class SignUpSerializer {
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final int? id;

  static const signUpEndpoint = "${settings.DOMAIN_NAME}/user/";

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
    int id = signUpDict["id"];
    return SignUpSerializer(
        firstName: firstName, lastName: lastName, email: email, id: id);
  }

  Map<String, dynamic> toMap({List<String>? exclude}) {
    Map<String, dynamic> map = {
      "first_name": firstName, "last_name": lastName,
      "email": email, "password": password, // "id": id
    };
    if (exclude != null) {
      for (String val in exclude) {
        if (map.containsKey(val)) {
          map.remove(val);
        }
      }
    }
    return map;
  }

  Future<utils.BoolData> post({List<String>? exclude}) async {
    // Http data
    Map httpBody = toMap(exclude: exclude);
    Uri url;
    if (foundation.kDebugMode) {
      url = Uri.parse("${settings.LOCAL_HOST}/user/");
    } else {
      url = Uri.parse(signUpEndpoint);
    }
    Map<String, dynamic>? respBody;
    // Make Request
    try {
      print("httpbody: $httpBody");
      http.Response resp = await http.post(url,
          body: httpBody,
          headers: {"content-type": "application/x-www-form-urlencoded"});
      print("Resp: $resp");
      respBody = jsonDecode(resp.body);
      if (resp.statusCode == 201) {
        print("about to save prefs");
        savePrefs(respBody!);
        print("I Saved prefs");
        return utils.BoolData(status: true, data: respBody);
      } else {
        return utils.BoolData(status: false, data: respBody);
      }
    } catch (e) {
      return utils.BoolData(status: false, data: e);
    }
  }

  Future<void> savePrefs(Map<String, dynamic> respBody) async {
    SignUpSerializer signUpInst = SignUpSerializer.json(respBody);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", signUpInst.id!);
    prefs.setString("first_name", signUpInst.firstName);
    prefs.setString("last_name", signUpInst.lastName);
    prefs.setString("email", signUpInst.email);
    prefs.setBool("user_exists", true);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}


class SignInSerializer {
  final String email;
  final String password;

  static const signInEndpoint = "${settings.DOMAIN_NAME}/api/token/";

  SignInSerializer({required this.email, required this.password});

  factory SignInSerializer.json(Map<String, dynamic> signUpDict) {
    String email = signUpDict["email"];
    String password = signUpDict["password"];
    return SignInSerializer(email: email, password: password);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "email": email, "password": password,
    };
    return map;
  }

  Future<utils.BoolData> getTokenPair({List<String>? exclude}) async {
    // Http data
    Map httpBody = toMap();
    Uri url;
    if (foundation.kDebugMode) {
      url = Uri.parse("${settings.LOCAL_HOST}/api/token/");
    } else {
      url = Uri.parse(signInEndpoint);
    }
    Map<String, dynamic>? respBody;
    // Make Request
    try {
      http.Response resp = await http.post(url,
          body: httpBody,
          headers: {"content-type": "application/x-www-form-urlencoded"});
      respBody = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        savePrefs(respBody!);   // Save tokens
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Todo: Call User.getUser for this, but for sake of time constraint, allow.
        // Todo: A future builder will then build the dashboard page.
        UserSerializer user = UserSerializer.fromPrefs(prefs);
        return utils.BoolData(status: true, data: user);
      } else {
        return utils.BoolData(status: false, data: respBody);
      }
    } catch (e) {
      return utils.BoolData(status: false, data: e);
    }
  }

  Future<void> savePrefs(Map<String, dynamic> respBody) async {
    String refresh = respBody["refresh"];
    String access = respBody["access"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh_token", refresh);
    prefs.setString("access_token", access);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
