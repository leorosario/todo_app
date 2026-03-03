import 'package:flutter/material.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/storage_service.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_filter.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  final _allTodosNotifier = ValueNotifier<List<Todo>>([]);
  TodoFilter _currentFilter = TodoFilter.all;
  String _currentQuery = '';
  final _storageService = getIt<StorageService>();

  List<Todo> get _todos => _allTodosNotifier.value;

  void init() async{
    _allTodosNotifier.value = await _storageService.getTodos();
    _allTodosNotifier.addListener(() { 
      _upateTodoList();
      _saveTodoListToDB();
    });
  }

  void add(Todo todo){
    _allTodosNotifier.value = [..._todos, todo];
  }

  void update(String id, String task){
    _allTodosNotifier.value = [
      for( final todo in _todos)
        if(todo.id != id) todo else todo.copyWith(task: task)
      
    ];
  }

  void toogle(String id){
    _allTodosNotifier.value = [
      for( final todo in _todos)
        if(todo.id != id) todo else todo.copyWith(completed: !todo.completed)
      
    ];
  }

  void remove(String id){
    _allTodosNotifier.value = _todos.where((todo) => todo.id != id).toList();
  }

  void reorder(List<Todo> todos){
    _allTodosNotifier.value = todos;
  }

  void changeFilter(TodoFilter filter){
    _currentFilter = filter;
    _upateTodoList();
  }

  
  void changeSearch(String query) {
    _currentQuery = query;
    _upateTodoList();
  }


  void _upateTodoList(){
    value = _mapFilterToTodoList();
  }

  void _saveTodoListToDB(){
    _storageService.saveTodos(_todos.where((todo) => todo.task.isNotEmpty).toList());
  }

  
  List<Todo> _mapFilterToTodoList() {
    Iterable<Todo> items = _todos;

    // 1) Filtra por status
    switch (_currentFilter) {
      case TodoFilter.incomplete:
        items = items.where((t) => !t.completed);
        break;
      case TodoFilter.completed:
        items = items.where((t) => t.completed);
        break;
      case TodoFilter.all:
        // nenhum filtro por status
        break;
    }

    // 2) Filtra por texto
    final q = _currentQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      items = items.where((t) => (t.task).toLowerCase().contains(q));
    }

    return items.toList(growable: false);
  }

}