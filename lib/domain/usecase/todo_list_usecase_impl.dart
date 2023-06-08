import '../model/todo_list_model.dart';
import '../repository/todo_list_repository.dart';
import 'todo_list_usecase.dart';

class GetTodoListUseCaseImpl implements GetTodoListUseCase {
  final TodoListRepository _repository;

  const GetTodoListUseCaseImpl(this._repository);

  @override
  Future<TodoList> execute() => _repository.getTodoList();
}

class CreateTodoUseCaseImpl implements CreateTodoUseCase {
  final TodoListRepository _repository;

  const CreateTodoUseCaseImpl(this._repository);

  @override
  Future<Todo> execute(
    String title,
    String description,
    bool isCompleted,
    DateTime dueDate,
  ) {
    return _repository.createTodo(title, description, isCompleted, dueDate);
  }
}

class UpdateTodoUseCaseImpl implements UpdateTodoUseCase {
  final TodoListRepository _repository;

  const UpdateTodoUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final TodoId id,
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  ) {
    return _repository.updateTodo(id, title, description, isCompleted, dueDate);
  }
}

class DeleteTodoUseCaseImpl implements DeleteTodoUseCase {
  final TodoListRepository _repository;

  const DeleteTodoUseCaseImpl(this._repository);

  @override
  Future<void> execute(TodoId id) => _repository.deleteTodo(id);
}
