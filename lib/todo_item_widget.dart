import 'package:flutter/material.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_list_controller.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late TextEditingController todoController;
  final controller = getIt<TodoListController>();

  @override
  void initState(){
    todoController = TextEditingController(text: widget.todo.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        controller: todoController,
        decoration: InputDecoration(
          hintText: 'escreva sua tarefa...',
        ),
        onChanged: onChanged,
      ),
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: onToggled
      ),
      trailing: IconButton(
        onPressed: onDeleted,
        visualDensity: VisualDensity.compact,
        icon: Icon(Icons.close_rounded),
      ),
    );
  }

  void onChanged(String task){
    print(task);
    controller.update(widget.todo.id, task);
  }

  void onToggled(_){
    controller.toogle(widget.todo.id);
  }

  void onDeleted(){
    print("Deleted");
  }
}