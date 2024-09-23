import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/task_model.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoPageState();
}

class _TodoPageState extends State<Todo> {
  // Variable of type Task List, which will temporarily store our tasks.
  List<TaskModel> tasksList = [];
  //instance of TextEditingController
  final TextEditingController taskTextEditingController =
      TextEditingController();
  // Variable we will use to perform SharedPreferences actions
  SharedPreferences? sharedPreferences;

  // Function that is called whenever our widget is rebuilt
  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  // Initializes SharedPreferences for use
  void initPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    readTasks();
  }

  //function responsible for serializing the tasksList into JSON format and saving it in local storage
  void saveOnLocalStorage() {
    final taskData = tasksList.map((task) => task.toJson()).toList();
    sharedPreferences?.setStringList('tasks', taskData);
  }

  // Function to add a new item to the List
  void createTask({required TaskModel task}) {
    setState(() {
      tasksList.add(task);
      saveOnLocalStorage();
    });
  }

  //function reads tasks stored in LocalStorage
  void readTasks() {
    setState(() {
      final taskData = sharedPreferences?.getStringList('tasks') ?? [];
      tasksList =
          taskData.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
    });
  }

// Function to update a Task in the List based on its ID
  void updateTask({required String taskId, required TaskModel updatedTask}) {
    final taskIndex = tasksList.indexWhere((task) => task.id == taskId);
    setState(() {
      tasksList[taskIndex] = updatedTask;
      saveOnLocalStorage();
    });
  }

// Function to delete a Task from the List based on its ID
  void deleteTask({required String taskId}) {
    setState(() {
      tasksList.removeWhere((task) => task.id == taskId);
      saveOnLocalStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('My To-Do List'),
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
                                  // Updates the tasks state when checking or unchecking the CheckBox.
                                  final TaskModel updatedTask = task;
                                  updatedTask.isCompleted = isChecked!;
                                  updateTask(
                                    taskId: updatedTask.id,
                                    updatedTask: updatedTask,
                                  );
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
                                // Delete the task when the IconButton is pressed
                                deleteTask(taskId: task.id);
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
          // Function that displays a Dialog/Modal
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
                      // Add the task described in the
                      //TextField to the list if the text field is not empty
                      if (taskTextEditingController.text.isNotEmpty) {
                        final TaskModel newTask = TaskModel(
                          id: DateTime.now().toString(),
                          title: taskTextEditingController.text,
                        );
                        createTask(task: newTask);

                        // Clear the Text Field
                        taskTextEditingController.clear();

                        // Close the Dialog
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
