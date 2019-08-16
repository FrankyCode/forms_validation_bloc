import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void showAlert(BuildContext context, String sms) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Wrong Info'),
          content: Text(sms),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
