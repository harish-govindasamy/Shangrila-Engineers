import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final String projectId;

  const AddTaskScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: const Center(
        child: Text('Add Task Screen'),
      ),
    );
  }
}
