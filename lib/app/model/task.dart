class Task {
  Task(this.titleTask, {this.doneTask = false});

  Task.fromJson(Map<String, dynamic> map) {
    titleTask = map['title'];
    doneTask = map['done'];
  }

  late final String titleTask;
  late bool doneTask;

  Map<String, dynamic> toJson() {
    return {
      'title': titleTask,
      'done': doneTask,
    };
  }
}
