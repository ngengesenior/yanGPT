import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart';
import 'package:yangpt/injection_container.dart';
import 'package:yangpt/ui/app.dart';

void main() {
  registerSingletons();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyTabbedPage(),
    );
  }
}

