import 'package:flutter_base_riverpod/domain/model/todo_list_model.dart';

abstract class GetTodoListUseCase {
  Future<TodoList> execute();
}

abstract class CreateTodoUseCase {
  Future<Todo> execute(
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );
}

abstract class UpdateTodoUseCase {
  Future<void> execute(
    final TodoId id,
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );
}

abstract class DeleteTodoUseCase {
  Future<void> execute(final TodoId id);
}