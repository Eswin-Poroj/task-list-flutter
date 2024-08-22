import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/app/model/task.dart';

class TaskRepository {
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTask = prefs.getStringList('tasks') ?? [];
    jsonTask.add(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTask);
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTask = prefs.getStringList('tasks') ?? [];
    return jsonTask.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }

  Future<bool> saveTask(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTask = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('tasks', jsonTask);
  }
}
