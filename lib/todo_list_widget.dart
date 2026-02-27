import 'package:flutter/material.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_filter.dart';
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
        var isFilterAll = controller.filtterNotifie.value == TodoFilter.all;

        if(todoList.isEmpty && !isFilterAll){
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('vazio'),
              ),
          );
        }

        return ReorderableListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: todoList.length,
          buildDefaultDragHandles: isFilterAll,
          onReorder:  (oldIndex, newIndex) {
            debugPrint('onReorder -> old=$oldIndex new=$newIndex');
            controller.reorder(oldIndex, newIndex);
          },
          itemBuilder: (context, index){
            final todo = todoList[index];
            
            return ReorderableDragStartListener(
              key: ValueKey(todo.id),   // a key precisa estar AQUI
              index: index,
              child: TodoItemWidget(todo: todo),
            );

          },      
        );
      },);
    
  }
}