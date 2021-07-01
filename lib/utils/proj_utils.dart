import 'package:flutter/material.dart';



abstract class CustomWidget {
  BuildContext? context;
  bool showBox;
  Color? boxColor;
  static const Color defaultColor = Colors.black26;

  CustomWidget({this.context, this.showBox = false, this.boxColor});

  Widget make();
}
