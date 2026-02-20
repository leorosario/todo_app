import 'package:todo_app/todo_list_notifier.dart';

class TodoListController {
  final todoListNotifier = TodoListNotifier();

  void update(String id, String task){
    todoListNotifier.update(id, task);
  }

  void toogle(String id){
    todoListNotifier.toogle(id);
  }
}