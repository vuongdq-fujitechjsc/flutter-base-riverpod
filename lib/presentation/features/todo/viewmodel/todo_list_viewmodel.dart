import '../../../../data/model/todo_list_model.dart';
import 'package:flutter_base_riverpod/domain/usecase/todo_list_usecase.dart';
import 'package:flutter_base_riverpod/presentation/state/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListViewModel extends StateNotifier<State<TodoList>> {
  final GetTodoListUseCase _getTodoListUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TodoListViewModel(
    this._getTodoListUseCase,
    this._createTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
  ) : super(const State.init()) {
    _getTodoList();
  }

  _getTodoList() async {
    try {
      state = const State.loading();
      final todoList = await _getTodoListUseCase.execute();
      state = State.success(todoList);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  completeTodo(final Todo todo) {
    final newTodo = todo.copyWith(isCompleted: true);
    updateTodo(newTodo);
  }

  undoTodo(final Todo todo) {
    final newTodo = todo.copyWith(isCompleted: false);
    updateTodo(newTodo);
  }

  addTodo(
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  ) async {
    try {
      final newTodo = await _createTodoUseCase.execute(
        title,
        description,
        isCompleted,
        dueDate,
      );
      state = State.success(state.data!.addTodo(newTodo));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  updateTodo(final Todo newTodo) async {
    try {
      await _updateTodoUseCase.execute(
        newTodo.id,
        newTodo.title,
        newTodo.description,
        newTodo.isCompleted,
        newTodo.dueDate,
      );
      state = State.success(state.data!.updateTodo(newTodo));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  deleteTodo(final TodoId id) async {
    try {
      await _deleteTodoUseCase.execute(id);
      state = State.success(state.data!.removeTodoById(id));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}
