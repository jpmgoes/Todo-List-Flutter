import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/model/task.dart';

void main() {
  Task task = Task(id: 0);

  group("testing default Task instance", () {
    test("testing default title", () {
      expect(task.title, equals(""));
    });
    test("testing default description", () {
      expect(task.description, equals(""));
    });
    test("testing default completed", () {
      expect(task.completed, equals(false));
    });
  });
}
