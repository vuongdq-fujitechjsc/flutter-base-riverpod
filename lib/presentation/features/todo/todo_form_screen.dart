import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/domain/model/todo_list_model.dart';
import 'package:flutter_base_riverpod/presentation/features/todo/todo_form_provider.dart';
import 'package:flutter_base_riverpod/presentation/features/todo/todo_form_viewmodel.dart';
import 'package:flutter_base_riverpod/shared/routes/app_router.dart';
import 'package:flutter_base_riverpod/shared/routes/route_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TodoFormScreen extends ConsumerStatefulWidget {
  final Todo? _todo;

  const TodoFormScreen(this._todo);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends ConsumerState<TodoFormScreen> {
  late final TodoFormViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();
  final _dueDateFormFocusNode = _DisabledFocusNode();
  late TextEditingController _dueDateTextFieldController;

  _TodoFormScreenState();

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(todoFormViewModelProvider(widget._todo));
    _dueDateTextFieldController = TextEditingController(
        text:
            DateFormat('yyyy/MM/dd').format(_viewModel.initialDueDateValue()));
  }

  @override
  void dispose() {
    _dueDateFormFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => ref.read(appRouterProvider).go(Routes.homeScreen),
        ),
        title: Text(_viewModel.appBarTitle()),
        actions: [
          if (_viewModel.shouldShowDeleteTodoIcon()) _buildDeleteTodoIcon()
        ],
      ),
      body: _buildBodyContainer(),
    );
  }

  Widget _buildBodyContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildForm(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildDeleteTodoIcon() {
    return IconButton(
        onPressed: () => _showConfirmDeleteTodoDialog(),
        icon: const Icon(Icons.delete));
  }

  _showConfirmDeleteTodoDialog() async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Delete ToDo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
    if (result) {
      _viewModel.deleteTodo();

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTitleFormWidget(),
          const SizedBox(height: 16),
          _buildDescriptionFormWidget(),
          const SizedBox(height: 16),
          _buildDueDateFormWidget()
        ],
      ),
    );
  }

  Widget _buildTitleFormWidget() {
    return TextFormField(
      initialValue: _viewModel.initialTitleValue(),
      maxLength: 20,
      onChanged: (value) => _viewModel.setTitle(value),
      validator: (_) => _viewModel.validateTitle(),
      decoration: const InputDecoration(
        icon: Icon(Icons.edit),
        labelText: 'Title',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionFormWidget() {
    return TextFormField(
      initialValue: _viewModel.initialDescriptionValue(),
      maxLength: 150,
      onChanged: (value) => _viewModel.setDescription(value),
      validator: (_) => _viewModel.validateDescription(),
      decoration: const InputDecoration(
        icon: Icon(Icons.view_headline),
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDueDateFormWidget() {
    return TextFormField(
      focusNode: _dueDateFormFocusNode,
      controller: _dueDateTextFieldController,
      maxLength: 50,
      onTap: () => _showDatePicker(context),
      onChanged: (value) => _viewModel.setTitle(value),
      validator: (_) => _viewModel.validateDescription(),
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: 'DueDate',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<DateTime?> _showDatePicker(final BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _viewModel.initialDueDateValue(),
      firstDate: _viewModel.datePickerFirstDate(),
      lastDate: _viewModel.datePickerLastDate(),
    );
    if (selectedDate != null) {
      _dueDateTextFieldController.text =
          DateFormat('yyyy/MM/dd').format(selectedDate);
      _viewModel.setDueDate(selectedDate);
    }

    return null;
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final currentState = _formKey.currentState;
          if (currentState != null && currentState.validate()) {
            _viewModel.createOrUpdateTodo();

            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
    );
  }
}

class _DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
