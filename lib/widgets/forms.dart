import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:rich_oak_fintech/utils/utils.dart' as utils;
import 'package:rich_oak_fintech/serializers/serializers.dart';
import 'package:rich_oak_fintech/widgets/status_widget.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool submitError = false;
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
    var screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: screenSize.width * 0.25,
          right: screenSize.width * 0.25,
        ),
        child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
        ),
        // width: 350,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "First Name"),
                controller: firstNameController,
                // initialValue: foundation.kDebugMode ? "Chidi" : "",
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  return res;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Last Name"),
                controller: lastNameController,
                // initialValue: foundation.kDebugMode ? "Nnadi" : "",
                validator: (value) {
                  String? res = utils.validatorConfirm(
                      [utils.FieldRequiredValidator()], value!);
                  return res;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                controller: emailController,
                // initialValue: foundation.kDebugMode ? "chidi@gmail.com" : "",
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
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.security),
                    )),
                // initialValue: foundation.kDebugMode ? "chidinnadi" : "",
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextConfPassword
                              ? obscureTextConfPassword = false
                              : obscureTextConfPassword = true;
                        });
                      },
                      icon: obscureTextConfPassword
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.security),
                    )),
                // initialValue: foundation.kDebugMode ? "chidinnadi" : "",
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
                          SignUpSerializer signUpInstance = SignUpSerializer(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          utils.BoolData resp;
                          signUpInstance.post(exclude: ["id"]).then(
                              (utils.BoolData value) => {
                                    if (value.status)
                                      {
                                        print("I ran too"),
                                        Navigator.of(context)
                                            .pushNamed("/user-dashboard")
                                      }
                                    else
                                      {
                                        print("I ran"),
                                        setState(() {
                                          submitError = true;
                                        }),
                                      }
                                  });
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: utils.TextStyles.defaultStyle,
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              submitError
                  ? StatusWidget(
                      message: "Sorry Couldn't Sign Up ", error: true)
                  : SizedBox(),
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
  bool submitError = false;
  bool obscureTextPassword = true;
  bool loadNextPage = false;
  late Future<bool> future;
  bool removeWarning = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: screenSize.width * 0.25,
          right: screenSize.width * 0.25,
        ),
        child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        // width: 350,
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
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.security),
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
                          SignInSerializer signInInstance = SignInSerializer(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          utils.BoolData resp;
                          signInInstance
                              .getTokenPair()
                              .then((utils.BoolData value) => {
                                    if (value.status)
                                      {
                                        print("I ran too"),
                                        Navigator.of(context)
                                            .pushNamed("/user-dashboard")
                                      }
                                    else
                                      {
                                        print("I ran"),
                                        setState(() {
                                          submitError = true;
                                        }),
                                      }
                                  });
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: utils.TextStyles.defaultStyle,
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              submitError
                  ? Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    submitError = false;
                                  });
                                },
                                icon: Icon(Icons.cancel)),
                          ),
                          ),
                        StatusWidget(
                            message: "Sorry Couldn't Sign In ", error: true),
                      ],
                    ),
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    ));
  }
}
