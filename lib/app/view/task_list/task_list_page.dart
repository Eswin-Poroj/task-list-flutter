import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('Hola, el contador es $count'),
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
