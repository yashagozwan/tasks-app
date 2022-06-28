import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  TextEditingController? controller;
  final String text;
  final bool checkboxValue;
  final void Function(bool?)? checkBoxOnChanged;
  final void Function() onDelete;
  final void Function()? onTap;

  final void Function()? onLongPress;
  bool isEditTask;
  final void Function()? onSave;

  TaskItem({
    Key? key,
    required this.text,
    required this.checkBoxOnChanged,
    required this.checkboxValue,
    required this.onDelete,
    this.onLongPress,
    this.onTap,
    this.isEditTask = false,
    this.controller,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isEditTask ? Colors.blue : Colors.white, width: 1)),
      child: ListTile(
        leading: Checkbox(
          shape: const CircleBorder(),
          onChanged: checkBoxOnChanged,
          value: checkboxValue,
        ),
        onLongPress: onLongPress,
        onTap: onTap,
        title: isEditTask
            ? TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  decoration: checkboxValue ? TextDecoration.lineThrough : null,
                  color: Colors.black,
                ),
              ),
        trailing: isEditTask
            ? IconButton(onPressed: onSave, icon: const Icon(Icons.update))
            : IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
      ),
    );
  }
}
