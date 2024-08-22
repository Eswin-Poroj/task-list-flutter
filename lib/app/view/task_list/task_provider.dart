import 'package:flutter/cupertino.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  final TaskRepository _taskRepository = TaskRepository();

  Future<void> fetchTasks() async {
    _taskList = await _taskRepository.getTasks();
    notifyListeners();
  }

  List<Task> get taskList => _taskList;

  void onTaskDoneChange(Task taskList) {
    taskList.doneTask = !taskList.doneTask;
    _taskRepository.saveTask(_taskList);
    notifyListeners();
  }

  void addNewTask(Task task) {
    _taskRepository.addTask(task);
    fetchTasks();
  }
}
