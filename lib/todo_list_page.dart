import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/new_todo_widget.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/todo_filter.dart';
import 'package:todo_app/todo_list_controller.dart';
import 'package:todo_app/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final controller = getIt<TodoListController>();
  static const List<Tab> tabs = [
    Tab(text: 'Todas'),
    Tab(text: 'A fazer'),
    Tab(text: 'Concluídas'),
  ];

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('To Do App'),
          bottom: TabBar(
            tabs: tabs,
            onTap: (index) {
              controller.changeFilter(TodoFilter.values[index]);
            },
          ),
        ),
        body: ListView(
          children: [
            ValueListenableBuilder(
              valueListenable: controller.filtterNotifie,
              builder: (context, filter, child) {
                if(filter == TodoFilter.completed){
                  return const SizedBox.shrink();
                }
                return NewTodoWidget();
              },
            ),

            TodoListWidget(),
          ],
        ),
      ),
    );
  }
}
