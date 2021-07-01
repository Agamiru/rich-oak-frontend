import 'package:flutter/material.dart';

import 'package:rich_oak_fintech/route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rich_Oak Fintech App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


