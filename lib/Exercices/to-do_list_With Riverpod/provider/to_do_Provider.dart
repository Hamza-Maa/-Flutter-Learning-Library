import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task_model.dart';


// StateNotifier for managing the list of tasks
class TaskListNotifier extends StateNotifier<List<TaskModel>> {
  TaskListNotifier() : super([]);

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    readTasks();
  }

  void readTasks() {
    final taskData = _prefs?.getStringList('tasks') ?? [];
    state = taskData.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
  }

  void saveOnLocalStorage() {
    final taskData = state.map((task) => task.toJson()).toList();
    _prefs?.setStringList('tasks', taskData);
  }

  void addTask(TaskModel task) {
    state = [...state, task];
    saveOnLocalStorage();
  }

  void updateTask(String taskId, TaskModel updatedTask) {
    state = [
      for (final task in state)
        if (task.id == taskId) updatedTask else task
    ];
    saveOnLocalStorage();
  }

  void deleteTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
    saveOnLocalStorage();
  }
}

// Provider for accessing TaskListNotifier
final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<TaskModel>>((ref) {
  final taskListNotifier = TaskListNotifier();
  taskListNotifier.init(); // Initialize SharedPreferences and load tasks
  return taskListNotifier;
});
