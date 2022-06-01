import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/pages/todo_bloc_page.dart';

void main() {
  group("Todo List - Page", (() {
    testWidgets("No task at screen test", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TodoBlocPage(),
      ));
      expect(find.byType(ListView), findsNothing);
      expect(find.text("Não há nada aqui"), findsNothing);
      expect(find.text("Adicione uma nova task"), findsNothing);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  }));
}
