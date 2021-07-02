import 'package:flutter/material.dart';

import 'package:rich_oak_fintech/utils/utils.dart' as utils;
import 'package:rich_oak_fintech/widgets/auto_size_buttons.dart';

class AppBar extends utils.CustomWidget {
  BuildContext? context;
  final String buttonName;
  final String title;
  void Function()? onClick;

  AppBar(
      {required this.context,
      required this.buttonName,
      required this.title,
      this.onClick});

  @override
  PreferredSize make() {
    var screenSize = MediaQuery.of(this.context!).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 50),
      child: Container(
        width: screenSize.width,
        color: Colors.lightBlue,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Row(
                children: [
                  Icon(Icons.view_headline_rounded),
                  SizedBox(width: 15),
                  Text(
                    "$title",
                    style: utils.TextStyles.defaultStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeTransparentButton(
                    widthAndHeight: Size.fromWidth(100),
                    padding: 9,
                    buttonName: "$buttonName",
                    onTapFunction: onClick == null
                        ? () {
                            Navigator.of(context!).pushNamed("/sign-in-page");
                          }
                        : onClick,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
