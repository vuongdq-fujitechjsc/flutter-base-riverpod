import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/todo_list_model.dart';
import '../viewmodel/todo_form_viewmodel.dart';
import 'todo_list_provider.dart';

final todoFormViewModelProvider =
    Provider.autoDispose.family<TodoFormViewModel, Todo?>((ref, todo) {
  final todoListViewModel =
      ref.watch(todoListViewModelStateNotifierProvider.notifier);
  return TodoFormViewModel(todo, todoListViewModel);
});