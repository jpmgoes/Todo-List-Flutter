import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/bloc/todo_state.dart';
import 'package:just_todo/model/task.dart';

void main() {
  List<Task> tasks = [];
  InicialTaskState inicialTaskState = InicialTaskState();
  TaskSuccessState taskSuccessState = TaskSuccessState(tasks: tasks);

  group("TaskState", () {
    test("InicialTaskState should be a TaskState", () {
      expect(inicialTaskState, allOf(isA<TaskState>()));
      expect(inicialTaskState.tasks, equals([]));
    });

    test("Inicial Task list should be empty", () {
      expect(inicialTaskState, allOf(isA<TaskState>()));
      expect(inicialTaskState.tasks, equals([]));
    });

    test("TaskSuccessState should be a TaskState", () {
      expect(taskSuccessState, isA<TaskState>());
    });
  });
}
