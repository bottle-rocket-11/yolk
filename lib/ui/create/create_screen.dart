import 'package:flutter/material.dart';

/// A screen widget that allows users to create a new task with subtasks.
class CreateTaskScreen extends StatefulWidget {
  /// Creates a new instance of the [CreateTaskScreen] widget.
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _subtaskControllers = [];

  @override
  void dispose() {
    _titleController.dispose();
    for (final controller in _subtaskControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSubtask() {
    setState(() {
      _subtaskControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                // Create task with subtasks and pop
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _subtaskControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _subtaskControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Subtask ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _subtaskControllers[index].dispose();
                              _subtaskControllers.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSubtask,
        tooltip: 'Add Subtask',
        child: const Icon(Icons.add),
      ),
    );
  }
}
