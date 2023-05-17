import 'package:flutter/material.dart';
import 'package:programming_hacks/modules/home/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/homeScreen',
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
