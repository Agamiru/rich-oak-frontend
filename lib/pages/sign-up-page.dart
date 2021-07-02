
import 'package:flutter/material.dart';
import 'package:rich_oak_fintech/widgets/widgets.dart' as widgets;
import 'package:rich_oak_fintech/utils/utils.dart' as utils;

class SignUpPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.AppBar(
          context: context, buttonName: "Sign In", title: "Rick Oak"
      ).make(),
      body: Container(
        // padding: EdgeInsets.only(top: 20, left: ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 80),
            Text("Create An Account",
                style: utils.TextStyles.defaultStyle
                    .copyWith(color: Colors.black87)),
            SizedBox(height: 10),
            widgets.SignUpForm(),
          ],
        ),
      ),
    );
  }
}
