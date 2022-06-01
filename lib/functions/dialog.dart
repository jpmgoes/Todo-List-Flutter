import '../constants/app_colors.dart';
import '../model/task.dart';
import 'package:flutter/material.dart';

import '../routes/page_routes.dart';
import '../validation/form_validations.dart';
import 'task_edti_functions.dart';

class Dialogs {
  static Future<void> showMyDialog(
    BuildContext context, {
    List<Task>? data,
    int? index,
    Task? taskArg,
  }) async {
    late Task task;

    if (data != null && index != null && taskArg == null) {
      task = data[index];
    } else {
      task = taskArg!;
    }

    return showDialog<void>(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text('Remover Task ${task.title!.toUpperCase()}'),
          content: const SingleChildScrollView(
            child: Text('Você gostaria de remover essa task?'),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: AppColors.alertColor,
              ),
              child: const Text('REMOVER'),
              onPressed: () {
                TaskEditFunctions.removeTask(task).then((value) {
                  FormValidation.scaffoldMessenger(
                    value,
                    context,
                    "TASK ${value?.toUpperCase()} REMOVIDA",
                    "TASK NÃO FOI REMOVIDA",
                  );
                  PageRoutes.toHomePage(context);
                });
              },
            ),
            TextButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
