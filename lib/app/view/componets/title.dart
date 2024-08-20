import 'package:flutter/material.dart';

class TitleAppH1 extends StatelessWidget {
  const TitleAppH1(this.texto, {super.key, this.color});

  final String texto;
  final Color?
      color; //Diciendole qué puede ser nulo y estó si tiene inicializado en el constructor

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
    );
  }
}
