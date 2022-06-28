import 'dart:math';

import 'package:flutter/material.dart';
import 'package:submission_flutter_pemula/screens/detail_screen.dart';
import 'package:submission_flutter_pemula/widgets/task_item.dart';
import '../model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _text = TextEditingController();
  final TextEditingController _updateText = TextEditingController();

  bool onFocus = false;
  final FocusNode _focus = FocusNode();
  List<TaskModel> _tasks = [];
  TaskModel editTask = TaskModel(id: 0, text: "", createdAt: 0, isDone: false);

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E2E7),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Tasks ${_tasks.isNotEmpty ? _tasks.length : ""}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (_tasks.isEmpty) _emptyTask() else _renderTasks(),
                ],
              ),
            ),
          ),
          _expandedEditText()
        ],
      ),
    );
  }

  Widget _emptyTask() {
    return Expanded(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            "Empty",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _renderTasks() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, int index) {
          TaskModel task = _tasks[index];
          return TaskItem(
            text: task.text,
            checkboxValue: task.isDone,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(task: task);
              }));
            },
            checkBoxOnChanged: (value) =>
                setState(() => task.isDone = !task.isDone),
            onDelete: () => _handleDeleteTask(task),
            onLongPress: () {
              setState(() {
                editTask = task;
                _updateText.text = editTask.text;
              });
            },
            isEditTask: editTask.id == task.id,
            controller: _updateText,
            onSave: () {
              setState(() {
                task.text = _updateText.text;
                editTask =
                    TaskModel(id: 0, text: "", createdAt: 0, isDone: false);
              });
            },
          );
        },
        itemCount: _tasks.length,
        separatorBuilder: (context, int index) => const SizedBox(height: 8),
      ),
    );
  }

  Widget _expandedEditText() {
    return Expanded(
      flex: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a new task",
                ),
                focusNode: _focus,
              ),
            ),
            Expanded(
              flex: 0,
              child: CircleAvatar(
                child: IconButton(
                  onPressed: _createTask,
                  icon: const Icon(Icons.save),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _createTask() {
    if (_text.text.isNotEmpty) {
      var task = TaskModel(
        id: Random().nextInt(10000),
        text: _text.text,
        isDone: false,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      setState(() => _tasks.add(task));
      _text.clear();
    }
  }

  void _handleDeleteTask(TaskModel task) {
    var filteredTask = _tasks.where((item) => item.id != task.id);
    setState(() => _tasks = filteredTask.toList());
  }

  void _onFocusChange() {
    setState(() => onFocus = _focus.hasFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _text.dispose();
    _focus.removeListener(_onFocusChange);
    _updateText.dispose();
  }
}
