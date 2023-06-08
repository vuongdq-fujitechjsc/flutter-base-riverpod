import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/model/todo_list_model.dart';
import '../../../shared/routes/app_router.dart';
import '../../../shared/routes/route_constant.dart';
import 'provider/filter_provider.dart';
import 'provider/todo_list_provider.dart';

class TodoListScreen extends ConsumerWidget {
  final _todoListProvider = todoListViewModelStateNotifierProvider;
  final _filteredTodoListProvider = filteredTodoListProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        children: [
          // filter chip bar
          const Divider(height: 2, color: Colors.grey),
          Consumer(
            builder: (context, ref, _) {
              return ref.watch(_filteredTodoListProvider).maybeWhen(
                  success: (content) => _buildTodoListContainer(ref, content),
                  error: (_) => _buildErrorContainer(),
                  orElse: () => const Expanded(
                      child: Center(child: CircularProgressIndicator())));
            },
          )
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context, ref),
    );
  }

  Widget _buildTodoListContainer(WidgetRef ref, final TodoList todoList) {
    if (todoList.length == 0) {
      return const Expanded(child: Center(child: Text("Data Empty")));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: todoList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return _buildTodoItem(context, ref, todoList[index]);
        },
      );
    }
  }

  Widget _buildTodoItem(
      final BuildContext context, final WidgetRef ref, final Todo todo) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd').format(todo.dueDate),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      todo.description.isEmpty
                          ? 'No description'
                          : todo.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              todo.isCompleted
                  ? _buildCheckedIcon(ref, todo)
                  : _buildUncheckedIcon(ref, todo),
            ],
          ),
        ),
      ),
      onTap: () {
        ref.read(appRouterProvider).push(Routes.todoFormScreen, extra: todo);
      },
    );
  }

  Widget _buildCheckedIcon(final WidgetRef ref, final Todo todo) {
    return InkResponse(
      onTap: () => ref.watch(_todoListProvider.notifier).undoTodo(todo),
      splashColor: Colors.transparent,
      child: const Icon(Icons.done, size: 24, color: Colors.lightGreen),
    );
  }

  Widget _buildUncheckedIcon(final WidgetRef ref, final Todo todo) {
    return InkResponse(
        onTap: () => ref.watch(_todoListProvider.notifier).completeTodo(todo),
        splashColor: Colors.transparent,
        child: const Icon(Icons.radio_button_off_rounded,
            size: 24, color: Colors.grey));
  }

  Widget _buildErrorContainer() {
    return const Center(child: Text("An error has occurred !"));
  }

  Widget _buildFloatingActionButton(
      final BuildContext context, final WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(appRouterProvider).push(Routes.todoFormScreen);
      },
      child: const Icon(Icons.add),
    );
  }
}
