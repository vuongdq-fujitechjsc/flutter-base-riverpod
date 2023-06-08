import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repository/todo_list_repository.dart';
import 'database/todo_list_database.dart';
import 'database/todo_list_database_impl.dart';
import 'repository/todo_list_repository_impl.dart';

final todosDatabaseProvider = Provider<TodosDatabase>((_) => TodosDatabaseImpl());
final todosRepositoryProvider =
    Provider<TodoListRepository>((ref) => TodosRepositoryImpl(ref.watch(todosDatabaseProvider)));
