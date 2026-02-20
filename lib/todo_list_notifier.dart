import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super(_initiaValue);

  static final List<Todo> _initiaValue = [
    Todo.create('Task 1'),
    Todo.create('Task 2'),
    Todo.create('Task 3'),
    Todo.create('Task 4'),
    Todo.create('Task 5'),
  ];

  void update(String id, String task){
    value = [
      for( final todo in value)
        if(todo.id != id) todo else todo.copyWith(task: task)
      
    ];
  }

  void toogle(String id){
    value = [
      for( final todo in value)
        if(todo.id != id) todo else todo.copyWith(completed: !todo.completed)
      
    ];
  }
}