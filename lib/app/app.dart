import 'package:flutter/material.dart';
import 'package:task_list/app/view/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const background = Color(0xFFF5F5F5);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          //color en el cual todo sé va a formar la app
          seedColor: primary,
        ),
        //color de fondo de pantalla
        scaffoldBackgroundColor: background,
        //Color de texto y fuente para toda la app
        textTheme: Theme.of(context).textTheme.apply(
              // declara el tipo de texto
              fontFamily: 'Poppins',
              //declara el color del texto en toda la app
              bodyColor: textColor,
              //textos de tipos de titulos o subtitulos
              displayColor: textColor,
            ),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
