import 'package:flutter/material.dart';
import 'package:task_list/app/view/home/inherited_widgets.dart';
import 'package:task_list/app/view/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const background = Color(0xFFF5F5F5);
    return SpecialColor(
      color: Colors.redAccent,
      child: MaterialApp(
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
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors
                .transparent, // Este widget sirve para especificar los colores o estilos del botón al ser seleccionado
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                54,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
