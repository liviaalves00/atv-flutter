import 'package:flutter/material.dart';
import 'package:projeto_final_fltter/src/views/contact_view.dart';
import 'package:projeto_final_fltter/src/views/home_view.dart';
import 'package:projeto_final_fltter/src/views/login_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/home': (context) => HomeView(),
        '/contacts': (context) => ContactsView(),
        // '/map': (context) => MapView(),
      },
    );
  }
}
