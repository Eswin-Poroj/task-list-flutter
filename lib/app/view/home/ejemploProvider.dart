import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatePage extends StatelessWidget {
  const StatePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmailProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EmailTextField(),
              const SizedBox(height: 20),
              _SendButton(),
              const SizedBox(height: 20),
              _EmailText(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailText extends StatelessWidget {
  //
  //Esta es una forma de actualizar un provider.
  //@override
  //Widget build(BuildContext context) {
  //final email = context.watch<EmailProvider>().email;
  //return Text('El email introducido es: $email');
  //}

  //Hay otra forma de actualizar, pero está sería de un widget llamado Consumer
  //Esta es la otra forma de actualizar, pero con está forma, solo lo qué esta en el widget se va a actualizar.
  //Pero por optimización, a veces es mejor usar esta forma
  @override
  Widget build(BuildContext context) {
    return Consumer<EmailProvider>(builder: (_, emailProvider, child) {
      return Text('El email introducido es: ${emailProvider.email}');
    });
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Enviar'),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      //Esto es una forma, pero la librería nos provee otra forma más comoda con menos sintxis
      //onChanged: (value) => Provider.of<EmailProvider>(context).email = value,
      /*onChanged:(value) => context.watch(), Es cuando quiero estar atento a los cambios de este provider, es decir que cada cambio qué se haga que se actualice. Pero en esté caso cada qué se utilice en metodos (onChanged or onTap) siempre se utiliza con ".read()", por que accedemos a un metodo no a los valores de un estado que representa*/
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: 'Email',
      ),
    );
  }
}

class EmailProvider extends ChangeNotifier {
  /*@override
  void notifyListeners() {
    
    super.notifyListeners();
  }*/
  // Este metodo ayuda a qué todas las clases que estén escuchando a EmailProvider, está les va a notificar qué hay una actualización

  String _email = '';
  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }
}
