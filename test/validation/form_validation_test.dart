import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/validation/form_validations.dart';

void main() {
  final nameController = TextEditingController();

  group("form validations", () {
    test("It should not be able to create a task without title", () {
      expect(
        FormValidation.titleValidation(nameController),
        equals("A task requer título"),
      );
    });
    test("It should be able to create a task with title", () {
      nameController.text = "valid";
      expect(FormValidation.titleValidation(nameController), equals(null));
    });
  });
}
