import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/validation/form_validations.dart';

void main() {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  group("form validations", () {
    test("name validation", () {
      expect(
        FormValidation.titleValidation(nameController),
        equals("A task requer título"),
      );
      nameController.text = "valid";
      expect(FormValidation.titleValidation(nameController), equals(null));
    });
  });
}
