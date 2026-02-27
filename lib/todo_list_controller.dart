import 'package:flutter/widgets.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_filter.dart';
import 'package:todo_app/todo_list_notifier.dart';

class TodoListController {
  final todoListNotifier = TodoListNotifier();
  final filtterNotifie = ValueNotifier<TodoFilter>(TodoFilter.all);

  void init(){
    todoListNotifier.init();
    filtterNotifie.addListener(() => todoListNotifier.changeFilter(filtterNotifie.value));
  }

  void add(String task){
    todoListNotifier.add(Todo.create(task));
  }

  void update(String id, String task){
    todoListNotifier.update(id, task);
  }

  void toogle(String id){
    todoListNotifier.toogle(id);
  }

  void remove(String id){
    todoListNotifier.remove(id);
  }

  void changeFilter(TodoFilter filter){
    filtterNotifie.value = filter;
  }

  void reorder(oldIndex, newIndex){
    if(oldIndex < newIndex){
      newIndex -= 1;
    }
    final todos = todoListNotifier.value;
    final todo = todos.removeAt(oldIndex);
    todos.insert(newIndex, todo);

    todoListNotifier.reorder(todos);
  }
}