import 'package:flutter_base_riverpod/domain/domain_module.dart';
import 'package:flutter_base_riverpod/domain/model/todo_list_model.dart';
import 'package:flutter_base_riverpod/presentation/state/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'todo_list_viewmodel.dart';

final todoListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<TodoListViewModel, State<TodoList>>(
        (ref) {
  return TodoListViewModel(
    ref.watch(getTodoListUseCaseProvider),
    ref.watch(createTodoUseCaseProvider),
    ref.watch(updateTodoUseCaseProvider),
    ref.watch(deleteTodoUseCaseProvider),
  );
});
