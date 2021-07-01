import 'package:flutter/material.dart';
import 'package:rich_oak_fintech/pages/pages.dart' as pages;


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => pages.SignUpPage());
      case "/sign-in-page":
        return MaterialPageRoute(builder: (_) => pages.SignInPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute( [Object? wrongArgs]) {
    String msg = "I don't know how we got here";
    if (wrongArgs != null) {
      msg = "Something wrong with this arg: $wrongArgs";
    }
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text(msg)
        ),
      );
    });
  }
}

