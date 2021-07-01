import 'package:flutter/material.dart';
import 'package:rich_oak_fintech/utils/utils.dart' as utils;
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rich_oak_fintech/serializers/serializers.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool submit = false;
  bool obscureTextPassword = true;
  bool obscureTextConfPassword = true;

  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(top: 100),
        child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(top: 10),
        width: 400,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "First Name"),
                controller: firstNameController,
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  return res;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Last Name"),
                controller: lastNameController,
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  return res;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                controller: emailController,
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator(), utils.EmailValidator()],
                      value!);
                  return res;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextPassword
                              ? obscureTextPassword = false
                              : obscureTextPassword = true;
                        });
                      },
                      icon: obscureTextPassword
                          ? Icon(Icons.security)
                          : Icon(Icons.remove_red_eye),
                    )),
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  return res;
                },
                controller: passwordController,
                obscureText: obscureTextPassword,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    // errorText: ,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextConfPassword
                              ? obscureTextConfPassword = false
                              : obscureTextConfPassword = true;
                        });
                      },
                      icon: obscureTextConfPassword
                          ? Icon(Icons.security)
                          : Icon(Icons.remove_red_eye),
                    )),
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  if (res == null) {
                    res = value != passwordController.text
                        ? "Password Mismatch"
                        : null;
                  }
                  return res;
                },
                obscureText: obscureTextConfPassword,
                controller: confirmPasswordController,
              ),
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 100,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print("Yes");
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: utils.TextStyles.defaultStyle,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool submit = false;
  bool obscureTextPassword = true;
  bool loadNextPage = false;
  late Future<bool> future;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> getFuture() async {
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
    res = await Future.delayed(Duration(seconds: 1), () => res);
    if (!res.containsKey("access")) {
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("access_token", res["access"]);
      prefs.setString("refresh_token", res["refresh"]);
      print("I ran");
      SignUpSerializer signUpInst = SignUpSerializer.json(res["user"]);
      await signUpInst.savePrefs();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("save successful: ${prefs.getString('access_token')}");
    loadNextPage = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(top: 10),
        width: 400,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                controller: emailController,
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator(), utils.EmailValidator()],
                      value!);
                  return res;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextPassword
                              ? obscureTextPassword = false
                              : obscureTextPassword = true;
                        });
                      },
                      icon: obscureTextPassword
                          ? Icon(Icons.security)
                          : Icon(Icons.remove_red_eye),
                    )),
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  return res;
                },
                controller: passwordController,
                obscureText: obscureTextPassword,
              ),
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 100,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            future = getFuture();
                          });
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: utils.TextStyles.defaultStyle,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
