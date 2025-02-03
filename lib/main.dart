import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/contact_controller.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
// import 'views/register_view.dart';
// import 'views/map_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ContactController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        // '/register': (context) => RegisterView(),
        '/home': (context) => HomeView(),
        // '/map': (context) => MapView(),
      },
    );
  }
}
