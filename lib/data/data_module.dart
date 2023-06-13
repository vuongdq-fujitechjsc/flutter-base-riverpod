import 'package:flutter_base_riverpod/data/networking/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositories
import 'networking/api_provider.dart';
import 'repository/todo_list_repository.dart';
import 'repository/todo_list_repository_impl.dart';
import 'package:flutter_base_riverpod/domain/repository/auth_repository.dart';
import 'package:flutter_base_riverpod/data/repository/auth_repository_impl.dart';

// Providers
import 'database/todo_list_database.dart';
import 'database/todo_list_database_impl.dart';

final todosDatabaseProvider = Provider<TodosDatabase>((_) => TodosDatabaseImpl());
final todosRepositoryProvider =
    Provider<TodoListRepository>((ref) => TodosRepositoryImpl(ref.watch(todosDatabaseProvider)));

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return AuthRepositoryImpl(ref.watch(apiServiceProvider as AlwaysAliveProviderListenable<ApiService>));
});
