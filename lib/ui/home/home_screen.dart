import 'package:flutter/material.dart';
import 'package:yolk/ui/widgets/task_list_item.dart';

/// A stateful widget representing the main home page of the application.
///
/// This widget is the primary container for the home page content and manages
/// its own state, allowing it to update dynamically based on user interactions
/// or other events.
class HomeScreen extends StatefulWidget {
  /// A page widget representing the main home screen of the application.
  ///
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, Hugo'),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          TaskListItem(
            title: 'Shopping List',
            isComplete: false,
            onTap: () {},
            onCheckboxChanged: (value) {},
            completedSubtasks: 2,
            totalSubtasks: 5,
          ),
          TaskListItem(
            title: 'Test Task',
            isComplete: false,
            onTap: () {},
            onCheckboxChanged: (value) {},
            completedSubtasks: 2,
            totalSubtasks: 5,
          ),
          TaskListItem(
            title: 'Test Task',
            isComplete: false,
            onTap: () {},
            onCheckboxChanged: (value) {},
            completedSubtasks: 2,
            totalSubtasks: 5,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Create task or habit',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
