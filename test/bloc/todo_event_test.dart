import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/bloc/todo_event.dart';
import 'package:just_todo/model/task.dart';

void main() {
  Task task = Task(id: 0);
  AddTaskEvent addEvent = AddTaskEvent(task: task);
  RemoveTaskEvent removeEvent = RemoveTaskEvent(task: task);

  group("Teste TaskRepository method", () {
    test("AddTaskEvent extends TaskEvent", () {
      expect(addEvent, isA<TaskEvent>());
    });
    test("RemoveTaskEvent extends TaskEvent", () {
      expect(removeEvent, isA<TaskEvent>());
    });
  });
}
