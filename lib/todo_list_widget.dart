import 'package:flutter/material.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_item_widget.dart';
import 'package:todo_app/todo_list_controller.dart';

List<Todo> todoList = [
  Todo.create('Task 1'),
  Todo.create('Task 2'),
  Todo.create('Task 3'),
  Todo.create('Task 4'),
  Todo.create('Task 5'),
];

class TodoListWidget extends StatelessWidget {
  TodoListWidget({super.key});

  final controller = getIt<TodoListController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.todoListNotifier, 
      builder:(context, todoList, child){
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: todoList.length,
          itemBuilder: (context, index){
            return ListTile(
              title: TodoItemWidget(todo: todoList[index]),
            );
          },      
        );
      },);
    
  }
}