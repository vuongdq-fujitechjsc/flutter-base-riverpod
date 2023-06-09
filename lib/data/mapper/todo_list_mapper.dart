import '../entity/todo_list_entity.dart';
import '../model/todo_list_model.dart';
import 'todo_mapper.dart';

class TodoListMapper {
  static TodoList transformToModel(final TodoListEntity entities) {
    final values =
        entities.map((entity) => TodoMapper.transformToModel(entity)).toList();
    return TodoList(values: values);
  }

  static TodoListEntity transformToMap(final TodoList model) =>
      model.values.map((value) => TodoMapper.transformToMap(value)).toList();
}