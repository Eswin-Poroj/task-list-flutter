import 'package:flutter/material.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/view/componets/shape.dart';
import 'package:task_list/app/view/componets/title.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int count = 0;

  @override
  void initState() {
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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Expanded(child: _TaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //Esto sirve para actualizar la pantalla de la app.
            count++;
          });
        },
        child: const Icon(
          Icons.add,
        ),
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

class _TaskList extends StatefulWidget {
  const _TaskList({super.key});

  @override
  State<_TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<_TaskList> {
  final taskList = <Task>[
    Task('Sacar al Perro'),
    Task('Hacer las compras'),
    Task('Ir al Partido'),
  ];
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
                  onTap: () {
                    taskList[index].doneTask = !taskList[index].doneTask;
                    setState(() {});
                  },
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
