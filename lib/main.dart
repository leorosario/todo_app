import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/todo_list_page.dart';

void main() async{
  await Hive.initFlutter();

  setupGetIt();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(        
        colorScheme: .fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const TodoListPage(),
    );
  }
}

