import 'package:just_todo/functions/shared_pref.dart';
import 'package:just_todo/repository/task_repository.dart';
import 'package:flutter/material.dart';

import '../constants/preferences_keys.dart';
import '../model/task.dart';

class TaskEditFunctions {
  static Future<String?> removeTask(Task task) async {
    final sharedPref = SharedPref();
    final value = await sharedPref.read(PreferencesKeys.tasks);

    TaskRepository newTaskRepo = TaskRepository.fromJson(value);
    newTaskRepo = newTaskRepo.removeTaskRetuningThis(task);

    sharedPref.save(PreferencesKeys.tasks, newTaskRepo);
    return task.title;
  }

  static changingCompleted(Task task) async {
    final sharedPref = SharedPref();
    final value = await sharedPref.read(PreferencesKeys.tasks);
    var newTaskRepo = TaskRepository.fromJson(value);
    newTaskRepo = newTaskRepo.changeCompleted(task);
    sharedPref.save(PreferencesKeys.tasks, newTaskRepo);
  }

  static Future<String?> addTask(
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) async {
    final sharedPref = SharedPref();
    final value = await sharedPref.read(PreferencesKeys.tasks);

    if (value == null) return null;
    var newTaskRepo = TaskRepository.fromJson(value);

    final task = Task(
      title: titleController.text,
      description: descriptionController.text,
      completed: false,
      id: newTaskRepo.getTasks().length + 1,
    );

    newTaskRepo = newTaskRepo.addTaskReturningThis(task);

    sharedPref.save(PreferencesKeys.tasks, newTaskRepo);

    return task.title;
  }

  static Future<String?> updateTask(
    TextEditingController titleController,
    TextEditingController descriptionController,
    Task task,
  ) async {
    final sharedPref = SharedPref();
    final value = await sharedPref.read(PreferencesKeys.tasks);

    final taskUpdated = Task(
      title: titleController.text,
      description: descriptionController.text,
      completed: task.completed,
      id: task.id,
    );

    TaskRepository newTaskRepo = TaskRepository.fromJson(value);
    newTaskRepo = newTaskRepo.replace(taskUpdated);

    sharedPref.save(PreferencesKeys.tasks, newTaskRepo);

    return taskUpdated.title;
  }
}
