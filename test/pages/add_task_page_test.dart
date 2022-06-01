import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/pages/add_task_page.dart';

void main() {
  group("It should test the TodoList inicial page when has no task in the list",
      () {
    testWidgets("Test Default AddTaskPage", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AddTaskPage(),
      ));
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text("CRIAR UMA TASK"), findsOneWidget);
    });
  });
}
