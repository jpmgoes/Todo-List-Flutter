import 'package:flutter/material.dart';

class FormValidation {
  static String? titleValidation(
      TextEditingController controller, String error) {
    if (controller.text.isEmpty) return error;
    return null;
  }

  static String? scaffoldMessenger(
    String? value,
    BuildContext context,
    String success,
    String faild,
  ) {
    if (value != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(success)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(faild)),
      );
    }
    return null;
  }
}
