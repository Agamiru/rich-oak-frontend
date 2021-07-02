import 'package:flutter/material.dart';
import 'package:rich_oak_fintech/serializers/serializers.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:rich_oak_fintech/widgets/widgets.dart' as widgets;
import 'package:rich_oak_fintech/utils/utils.dart' as utils;
import 'package:rich_oak_fintech/serializers/serializers.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserDashboardPage extends StatefulWidget {
  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  late UserSerializer user;
  bool userIsReady = false;

  @override
  void initState() {
    getUser().then((value) => {user = value});
    super.initState();
  }

  Future<UserSerializer> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserSerializer.fromPrefs(prefs);
  }

  Widget build(BuildContext context) {
    // String firstName =
    return Scaffold(
      appBar: widgets.AppBar(
          context: context,
          title: "Bal: 0.0 N",
          buttonName: "Sign Out",
          onClick: () {
            Navigator.of(context).pushNamed("/sign-in-page");
          }).make(),
      body: FutureBuilder(
        future: getUser(),
        builder:
            (BuildContext context, AsyncSnapshot<UserSerializer> snapshot) {
          if (snapshot.hasData) {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 80),
                      RichText(
                          text: TextSpan(
                        text: "Welcome To Your Dashboard ",
                        style: utils.TextStyles.defaultStyle
                            .copyWith(color: Colors.black87),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${user.firstName.toUpperCase()}",
                            style: utils.TextStyles.defaultStyle
                                .copyWith(color: Colors.black87)
                                .apply(fontSizeFactor: 1.3, fontWeightDelta: 2),
                          ),
                        ],
                      )),
                      // Text(
                      //     "Welcome To Your Dashboard ${user.firstName.toUpperCase()}",
                      //     style: utils.TextStyles.defaultStyle
                      //         .copyWith(color: Colors.black87)),
                      // // SizedBox(height: 10),
                      // // widgets.SignInForm(),
                    ],
                  ),
                ));
          } else if (snapshot.hasError) {
            return BasicDashBoard();
          }
          return Center(
            child: Container(
                width: 90.0,
                height: 90.0,
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                )),
          );
        },
      ),
    );
  }
}

class BasicDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 80),
            Text("Welcome To Your Dashboard",
                style: utils.TextStyles.defaultStyle
                    .copyWith(color: Colors.black87)),
            // SizedBox(height: 10),
            // widgets.SignInForm(),
          ],
        ),
      ),
    );
  }
}
