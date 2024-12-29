import 'package:flutter/material.dart';
import 'package:yolk/core/constants/padding.dart';
import 'package:yolk/core/constants/spacing.dart';

/// A widget that displays a single task item in a list.
class TaskListItem extends StatelessWidget {
  /// Creates a new instance of the [TaskListItem] widget.
  TaskListItem({
    required this.title,
    required this.isComplete,
    required this.onTap,
    required this.onCheckboxChanged,
    this.completedSubtasks,
    this.totalSubtasks,
    super.key,
  }) : summary = _generateSummary(isComplete, completedSubtasks, totalSubtasks);

  /// The title of the task
  final String title;

  /// A brief description of the task status, auto-generated from completion and
  ///
  /// subtask data
  final String summary;

  /// Whether the task is completed
  final bool isComplete;

  /// Callback function when the task item is tapped
  final VoidCallback onTap;

  /// Callback function when task completion status changes
  final ValueChanged<bool?>? onCheckboxChanged;

  /// Number of completed subtasks, if any
  final int? completedSubtasks;

  /// Total number of subtasks, if any
  final int? totalSubtasks;

  static String _generateSummary(bool isComplete, int? completed, int? total) {
    if (completed != null && total != null) {
      return '$completed out of $total items completed';
    }
    if (isComplete) return 'complete';
    return 'in progress';
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Card.filled(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: AppSpacing.xs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        summary,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Checkbox(
                    value: isComplete,
                    onChanged: onCheckboxChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
