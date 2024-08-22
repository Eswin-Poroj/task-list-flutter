import 'package:flutter/material.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/repository/task_repository.dart';
import 'package:task_list/app/view/componets/shape.dart';
import 'package:task_list/app/view/componets/title.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TaskRepository taskRepository = TaskRepository();

  @override
  Future<void> initState() async {
    super.initState();
    //Esto sirve para actualizar el estado de una pantalla que va a iniciar
    //Esto es necesario para inicializar estados
  }

  @override
  void dispose() {
    super.dispose();
    // este metodo se ejecuta justo antes de eliminar la instancia de esté widget
    // Esto es interesante para liberar recursos, qué lo vamos a necesitar cuando queramos eliminar este widget
    // Esto sirve para limpiar los datos
  }

  @override
  Widget build(BuildContext context) {
    //Esto sirve para renderizar la UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),

        // Esto sirve para retroceder a una página anterior
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Center(
            child: Text('Atras'),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: taskRepository
                  .getTasks(), //esto me pregunta que metodo asincrono hay que llamar para cargar este listado de tareas
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Existen Tareas'),
                  );
                }

                return _TaskList(snapshot.data!, onTaskDoneChange: (task) {
                  task.doneTask = !task.doneTask;
                  taskRepository.saveTask(snapshot.data!);
                  setState(() {});
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTaskModal(context),
        /*() {
          setState(() {
            //Esto sirve para actualizar la pantalla de la app.
            count++;
          });
        },*/
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled:
            true, // Esto sirve para qué se se adapte el contenedor a los elementos qué contiene este y el scroll lo controla este widget
        builder: (_) => _NewTaskModal(
              onTaskCreated: (Task task) {
                setState(() {});
              },
            ));
  }
}

class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({super.key, required this.onTaskCreated});

  final _controller = TextEditingController();
  final void Function(Task task) onTaskCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 23,
          left: 33,
          right: 33,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              10), // Esto hace qué el modal no sea ocultado por el teclado del telefono
      //padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 23),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleAppH1('Nueva Tarea'),
          const SizedBox(height: 26),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true, //Esto es para darle un color de relleno
              fillColor: Colors.white, //Aquí le asignamos el color del relleno
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Descripción de la Tarea',
            ),
          ),
          const SizedBox(height: 26),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final task = Task(_controller.text);
                onTaskCreated(task);
                Navigator.of(context).pop();
              }
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(
    this.task, {
    super.key,
    this.onTap,
  });
  final Task task;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            21,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 18,
          ),
          child: Row(
            children: [
              Icon(
                task.doneTask
                    ? Icons.check_box_rounded
                    : Icons.check_box_outline_blank_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(task.titleTask),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context)
          .colorScheme
          .primary, //Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          const Row(
            children: [
              Shape(),
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/images/tasks-list-image.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(
                height: 16,
              ),
              const TitleAppH1(
                'Completa tus tareas',
                color: Colors.white,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList(this.taskList, {super.key, required this.onTaskDoneChange});

  final List<Task> taskList;
  final void Function(Task task) onTaskDoneChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleAppH1('Tareas'),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return _TaskItem(
                  taskList[index],
                  onTap: () => onTaskDoneChange(taskList[index]),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: taskList.length,
            ),
          ),
        ],
      ),
    );
  }
}
