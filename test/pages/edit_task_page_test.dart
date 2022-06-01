import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/pages/edit_task_page.dart';

void main() {
  group("", () {
    testWidgets("Test Default Widgets", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EditTaskPage(),
      ));

      expect(find.byType(ElevatedButton), findsWidgets);
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets(
        "It should verify checkbox when it activated and see what else happend in the view ",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EditTaskPage(),
      ));

      final checkboxFinder = find.byType(Checkbox);
      var checkbox = tester.firstWidget(checkboxFinder) as Checkbox;

      expect(checkbox.value, false);
      expect(find.text("AINDA NÃO CONCLUÍDA"), findsOneWidget);

      await tester.tap(checkboxFinder);
      await tester.pump();

      checkbox = tester.firstWidget(checkboxFinder) as Checkbox;
      expect(checkbox.value, true);
      expect(find.text("MARCADA COMO FEITA"), findsOneWidget);
    });
  });
}
