import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maam_riffat_mid_task/model/imgPicker.dart';
import 'package:maam_riffat_mid_task/model/user.dart';
import 'package:maam_riffat_mid_task/widgets/dialogBox.dart';

import '../database/databaseHandler.dart';
import '../widgets/SignInButton.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
//varaibles...
  File? img;

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  final _formkey = new GlobalKey<FormState>();

//start...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),

          //for validation
          child: Form(
            key: _formkey,

            //to add scroling feature
            child: SingleChildScrollView(
              child: Column(
                children: [
                
                  //for round profile photo
                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

                      if (image == null) {
                        return null;
                      }
                      final tempImg = File(image.path);
                      setState(() {
                        img = tempImg;
                      });
                    },
                    child: img == null
                        ? CircleAvatar(
                            backgroundColor: Colors.blue.shade300,
                            radius: 100,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(img!),
                            radius: 100,
                          ),
                  ),

                  //text
                  SizedBox(height: 10),
                  Text(
                    "SignUp",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  //USERNAME textfield
                  CustomTextForm(user, "Username", (val) {
                    if (val!.length == 0) {
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
                      return "length less than 8";
                    } else {
                      return null;
                    }
                  }),

                  SizedBox(height: 20),

                  CustomTextForm(confirmpass, "confirm password", (val) {
                    print(val);
                    if (val!.length == 0) {
                      return " empty";
                    } else if (val! != pass.text) {
                      return "not matching";
                    } else {
                      return null;
                    }
                  }),

                  SizedBox(height: 20),

                  //ending of textfields

                  //buttons for the screens
                  bottomButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton bottomButton() {
    return 
        ElevatedButton(
            onPressed: () {
              onCreate(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              primary: Colors.blue.shade400,
              shape: const StadiumBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Create Account",
                style: TextStyle(fontSize: 24),
              ),
            ));
      
  }

  void bottomSheetDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: widgetsInBottomSheet(),
            );
          }),
    );
  }

  Widget widgetsInBottomSheet() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        tipOnBottomSheet(),
        Column(children: [
          const SizedBox(
            height: 100,
          ),
          SignInButton(
            onTap: () async {
              dynamic img = await ImgPicker.fromCamera();
              if (img != null) {
                final tempImg = File(img.path);
                setState(() {
                  img = tempImg;
                });
              }
              Navigator.pop(context);
            },
            iconPath: 'assets/logos/camera.png',
            textLabel: 'Take from camera',
            backgroundColor: Colors.grey.shade300,
            elevation: 0.0,
          ),
          const SizedBox(
            height: 40,
          ),
          SignInButton(
            onTap: () async {
              dynamic img = await ImgPicker.fromGallery();
              if (img != null) {
                final tempImg = File(img.path);
                setState(() {
                  img = tempImg;
                });
              }

              Navigator.pop(context);
            },
            iconPath: 'assets/logos/gallery.png',
            textLabel: 'Take from gallery',
            backgroundColor: Colors.grey.shade300,
            elevation: 0.0,
          ),
        ])
      ],
    );
  }

  Widget tipOnBottomSheet() {
    return Positioned(
      top: -15,
      child: Container(
        width: 60,
        height: 7,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
      ),
    );
  }

  File? img2;

  void onCreate(BuildContext context) async {
    final bytes = img?.readAsBytesSync();
    String img64 = base64Encode(bytes!);
    User obj = User(username: user.text, password: pass.text, image: img64);
    await DatabaseHelper.instance.insertUser(obj);

   

    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text("Inserted..."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          ),
        );
      },
    );
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
