import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_module.dart';
import 'usecase/todo_list_usecase.dart';
import 'usecase/todo_list_usecase_impl.dart';

final getTodoListUseCaseProvider =
    Provider<GetTodoListUseCase>((ref) => GetTodoListUseCaseImpl(ref.watch(todosRepositoryProvider)));
final createTodoUseCaseProvider =
    Provider<CreateTodoUseCase>((ref) => CreateTodoUseCaseImpl(ref.watch(todosRepositoryProvider)));
final updateTodoUseCaseProvider =
    Provider<UpdateTodoUseCase>((ref) => UpdateTodoUseCaseImpl(ref.watch(todosRepositoryProvider)));
final deleteTodoUseCaseProvider =
    Provider<DeleteTodoUseCase>((ref) => DeleteTodoUseCaseImpl(ref.watch(todosRepositoryProvider)));