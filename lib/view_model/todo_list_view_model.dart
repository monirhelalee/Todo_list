import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/service/db_manager.dart';

class ToDoListViewModel extends ChangeNotifier {
  int _selectedPageNo = 0;
  List<Map<String, dynamic>> _todoList = [];
  List<Map<String, dynamic>> _completeTodoList = [];
  List<Map<String, dynamic>> _notCompleteTodoList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool _isLoading = true;
  bool _isUpdate = false;

  set selectedPageNo(int v) {
    _selectedPageNo = v;
    notifyListeners();
  }

  set isUpdate(bool v) {
    _isUpdate = v;
    notifyListeners();
  }

  getNotCompletedToDoList() async {
    final getData = await DbManager.getTodoList();
    _todoList = getData;
    _notCompleteTodoList = [];
    todoList.forEach((element) {
      if (element["isComplete"] == "f") {
        notCompleteTodoList.add(element);
      }
    });
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNewTodo() async {
    await DbManager.createTodo(
        title: titleController.text,
        details: descriptionController.text,
        isComplete: "f");
    notifyListeners();
  }

  Future<void> updateTodo(int id) async {
    await DbManager.updateTodo(
        id, titleController.text, descriptionController.text, "f");
    notifyListeners();
    // getEmployeeList();
  }

  void deleteTodo(int id) async {
    await DbManager.deleteTodo(id);
    BotToast.showText(text: "Successfully deleted the user!");
    notifyListeners();
    // getEmployeeList();
  }

  reset() {
    //_selectedPageNo = 0;
    // _todoList = [];
    // _completeTodoList = [];
    // _notCompleteTodoList = [];
    titleController.clear();
    descriptionController.clear();
    _isLoading = true;
    _isUpdate = false;
  }

  int get selectedPageNo => _selectedPageNo;
  bool get isLoading => _isLoading;
  bool get isUpdate => _isUpdate;
  List<Map<String, dynamic>> get todoList => _todoList;
  List<Map<String, dynamic>> get completeTodoList => _completeTodoList;
  List<Map<String, dynamic>> get notCompleteTodoList => _notCompleteTodoList;
}
