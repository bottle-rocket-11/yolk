import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yolk/ui/widgets/task_list_item.dart';

void main() {
  testWidgets('TaskListItem displays task correctly',
      (WidgetTester tester) async {
    var tapped = false;
    bool? checkboxValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskListItem(
            title: 'Test Task',
            isComplete: false,
            onTap: () => tapped = true,
            onCheckboxChanged: (value) => checkboxValue = value,
            completedSubtasks: 2,
            totalSubtasks: 5,
          ),
        ),
      ),
    );

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('2 out of 5 items completed'), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    expect(tapped, true);

    await tester.tap(find.byType(Checkbox));
    expect(checkboxValue, true);

    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, false);
  });
}
