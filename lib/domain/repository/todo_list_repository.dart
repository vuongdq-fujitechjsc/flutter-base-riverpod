import '../../data/model/todo_list_model.dart';

abstract class TodoListRepository {
  Future<TodoList> getTodoList();
  Future<Todo> createTodo(
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );
  Future<void> updateTodo(
    final TodoId id,
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );
  Future<void> deleteTodo(final TodoId id);
}