import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/todo_list_model.dart';
import '../../state/state.dart';
import 'filter_viewmodel.dart';
import 'todo_list_provider.dart';

enum FilterKind { all, completed, incomplete }

final filterKindViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<FilterKindViewModel, FilterKind>((_) => FilterKindViewModel());

final filteredTodoListProvider = Provider.autoDispose<State<TodoList>>((ref) {
  final filterKind = ref.watch(filterKindViewModelStateNotifierProvider);
  final todoListState = ref.watch(todoListViewModelStateNotifierProvider);

  return todoListState.when(
    init: () => const State.init(),
    success: (todoList) {
      switch (filterKind) {
        case FilterKind.all:
          return State.success(todoList);
        case FilterKind.completed:
          return State.success(todoList.filterByCompleted());
        case FilterKind.incomplete:
          return State.success(todoList.filterByIncomplete());
      }
    },
    loading: () => const State.loading(),
    error: (exception) => State.error(exception),
  );
});
