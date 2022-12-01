import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  String msg;

  AlertBox({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(msg),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}
