import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/bloc/todo_event.dart';
import 'package:just_todo/model/task.dart';

void main() {
  Task task = Task(id: 0);
  AddTaskEvent addEvent = AddTaskEvent(task: task);
  RemoveTaskEvent removeEvent = RemoveTaskEvent(task: task);

  group("TaskEvent", () {
    test("AddEvent should be a TaskEvent", () {
      expect(addEvent, isA<TaskEvent>());
    });
    test("the Task from AddEvent should be a Task", () {
      expect(addEvent.task, isA<Task>());
    });

    test("RemoveEvent should be a TaskEvent", () {
      expect(removeEvent, isA<TaskEvent>());
    });
    test("the Task from RemoveEvent should be a Task", () {
      expect(removeEvent.task, isA<Task>());
    });
  });
}
