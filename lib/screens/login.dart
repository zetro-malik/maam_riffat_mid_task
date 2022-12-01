import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maam_riffat_mid_task/screens/products.dart';
import 'package:maam_riffat_mid_task/screens/signup.dart';
import 'package:maam_riffat_mid_task/widgets/dialogBox.dart';

import '../database/databaseHandler.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //varaibles
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  //start...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.all(50.0), child: LoginForm()),
      ),
    );
  }

  Widget LoginForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "login",
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 70),
            CustomTextForm(user, "username", (val) {
              if (val?.length == 0) {
                return "username cannot be empty";
              } else {
                return null;
              }
            }),
            SizedBox(height: 20),
            CustomTextForm(pass, "password", (val) {
              if (val!.length == 0) {
                return "password cannot be empty";
              } else if (val!.length < 8) {
                return "password length should be greater than 8";
              } else {
                return null;
              }
            }),
            SizedBox(height: 50),
            Login_SignUp_Buttons(),
          ],
        ),
      ),
    );
  }

  Row Login_SignUp_Buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(login, "Login"),
        SizedBox(height: 20),
        CustomElevatedButton(() {
          _navigateToNextScreen(context);
        }, "SignUp"),
      ],
    );
  }

  void login() async {
    String user_exits = "not found";
    if (await DatabaseHelper.instance.checkUser(user.text, pass.text)) {
      user_exits = "User exits";
    }
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return productView();
        },
      ));
      // showDialog(
      //     context: context,
      //     builder: ((context) {
      //       return Container(
      //         child: AlertDialog(
      //           title: Text(user_exits),
      //           actions: [
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 child: Text("OK"))
      //           ],
      //         ),
      //       );
      //     }));
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUp()));
  }

  ElevatedButton CustomElevatedButton(func, String msg) {
    return ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.blue.shade400,
          shape: const StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            msg,
            style: TextStyle(fontSize: 24),
          ),
        ));
  }

  TextFormField CustomTextForm(TextEditingController con, String msg, func) {
    return TextFormField(
      controller: con,
      decoration: InputDecoration(
        labelText: msg,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: new BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: func,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
