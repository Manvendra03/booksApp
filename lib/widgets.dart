import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notary_app/custom_colors.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

void showtoast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: textField_color,
      textColor: black_color,
      fontSize: 16.0);
}
