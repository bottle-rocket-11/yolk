import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yolk/bloc/auth/auth_bloc.dart';
import 'package:yolk/bloc/auth/auth_event.dart';
import 'package:yolk/core/constants/padding.dart';
import 'package:yolk/core/constants/spacing.dart';
import 'package:yolk/core/di.dart';
import 'package:yolk/core/routing/routes.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => getIt<AuthBloc>().add(AuthLogoutPressedEvent()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.sm),
        child: Column(
          spacing: AppSpacing.sm,
          children: [
            TaskListItem(
              title: 'Shopping List',
              isComplete: false,
              onTap: () => context.go(Routes.auth.path),
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
              isComplete: true,
              onTap: () {},
              onCheckboxChanged: (value) {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(Routes.create.path),
        tooltip: 'New Task or Habit',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
