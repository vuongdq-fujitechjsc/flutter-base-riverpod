import 'package:flutter/widgets.dart';
import 'package:flutter_base_riverpod/presentation/features/todo/todo_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoListScreen();
  }
}