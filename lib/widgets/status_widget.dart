import 'package:flutter/material.dart';

import 'package:rich_oak_fintech/utils/utils.dart' as utils;

class StatusWidget extends StatelessWidget {
  final String message;
  final bool error;

  StatusWidget({required this.message, required this.error});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: error
            ? Colors.pinkAccent.withOpacity(0.5)
            : Colors.lightBlue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: FittedBox(
        child: Text(
            message,
            style: utils.TextStyles.defaultStyle.copyWith(
              shadows: [Shadow(color: Colors.black26, offset: Offset(1, 1))]
            )
        ),
      ),
    );
  }
}
