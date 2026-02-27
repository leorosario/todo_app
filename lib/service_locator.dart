import 'package:get_it/get_it.dart';
import 'package:todo_app/hive_storage.dart';
import 'package:todo_app/storage_service.dart';
import 'package:todo_app/todo_list_controller.dart';

final getIt = GetIt.instance;

void setupGetIt(){
  getIt.registerLazySingleton<TodoListController>(() => TodoListController());
  getIt.registerLazySingleton<StorageService>(() => HiveStorage());
}