import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/task_model.dart';
import '../provider/to_do_Provider.dart';

class TodoWithRiverpod extends ConsumerWidget {
  final TextEditingController taskTextEditingController =
      TextEditingController();

  TodoWithRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the list of tasks from the provider
    final tasksList = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('My To-Do List With Riverpod'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: tasksList.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ListView.builder(
                        itemCount: tasksList.length,
                        itemBuilder: (context, index) {
                          final TaskModel task = tasksList[index];
                          return ListTile(
                            leading: Transform.scale(
                              scale: 2.0,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                value: task.isCompleted,
                                onChanged: (isChecked) {
                                  final updatedTask = TaskModel(
                                    id: task.id,
                                    title: task.title,
                                    isCompleted: isChecked!,
                                  );
                                  ref
                                      .read(taskListProvider.notifier)
                                      .updateTask(task.id, updatedTask);
                                },
                              ),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                color: task.isCompleted
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontSize: 20,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // Delete the task
                                ref
                                    .read(taskListProvider.notifier)
                                    .deleteTask(task.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                                size: 30.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'No tasks registered, tap the button with the + symbol',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  controller: taskTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Describe your task',
                  ),
                  maxLines: 2,
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (taskTextEditingController.text.isNotEmpty) {
                        final TaskModel newTask = TaskModel(
                          id: DateTime.now().toString(),
                          title: taskTextEditingController.text,
                        );
                        ref.read(taskListProvider.notifier).addTask(newTask);
                        taskTextEditingController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
