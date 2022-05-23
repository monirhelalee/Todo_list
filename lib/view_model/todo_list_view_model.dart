import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/service/db_manager.dart';

class ToDoListViewModel extends ChangeNotifier {
  int _selectedPageNo = 0;
  int _onBoardingIndex = 0;
  List<Map<String, dynamic>> _todoList = [];
  List<Map<String, dynamic>> _completeTodoList = [];
  List<Map<String, dynamic>> _notCompleteTodoList = [];
  List<Map<String, dynamic>> _notCompleteTodoSearchList = [];
  List<Map<String, dynamic>> _completeTodoSearchList = [];
  final TextEditingController notCompleteTodoSearchController =
      TextEditingController();
  final TextEditingController completeTodoSearchController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final PageController onBoardPageController = PageController();
  bool _isLoading = true;
  bool _isUpdate = false;

  set selectedPageNo(int v) {
    _selectedPageNo = v;
    notifyListeners();
  }

  set onBoardingIndex(int v) {
    _onBoardingIndex = v;
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
    for (var element in todoList) {
      if (element["isComplete"] == "f") {
        _notCompleteTodoList.add(element);
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getSearchResultNotCompletedToDoList({String? q}) async {
    final getData = await DbManager.getTodoList();
    _todoList = getData;
    List<Map<String, dynamic>> _list1 = [];
    List<Map<String, dynamic>> _nctList = [];
    for (var element in todoList) {
      if (element["isComplete"] == "f") {
        _nctList.add(element);
      }
    }
    for (var item in _nctList) {
      if (item['title'].toLowerCase().contains(q?.toLowerCase())) {
        _list1.add(item);
      }
    }
    //print(" test search ${_list1.length}");
    _notCompleteTodoSearchList.clear();
    _notCompleteTodoSearchList = _list1;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getSearchResultCompletedToDoList({String? q}) async {
    final getData = await DbManager.getTodoList();
    _todoList = getData;
    List<Map<String, dynamic>> _list1 = [];
    List<Map<String, dynamic>> _ctList = [];
    for (var element in todoList) {
      if (element["isComplete"] == "t") {
        _ctList.add(element);
      }
    }
    for (var item in _ctList) {
      if (item['title'].toLowerCase().contains(q?.toLowerCase())) {
        _list1.add(item);
      }
    }
    //print(" complete todo search ${_list1.length}");
    _completeTodoSearchList.clear();
    _completeTodoSearchList = _list1;
    _isLoading = false;
    notifyListeners();
  }

  getCompletedToDoList() async {
    final getData = await DbManager.getTodoList();
    _todoList = getData;
    _completeTodoList = [];
    for (var element in todoList) {
      if (element["isComplete"] == "t") {
        _completeTodoList.add(element);
      }
    }
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
  }

  Future<void> completeTodo(
      {required int id,
      required String title,
      required String isComplete,
      String? details}) async {
    await DbManager.updateTodo(id, title, details, isComplete);
    notifyListeners();
  }

  Future<void> deleteTodo({required int id}) async {
    await DbManager.deleteTodo(id);
    BotToast.showText(text: "Successfully deleted!");
    notifyListeners();
  }

  reset() {
    _notCompleteTodoSearchList = [];
    titleController.clear();
    descriptionController.clear();
    completeTodoSearchController.clear();
    notCompleteTodoSearchController.clear();
    _isLoading = true;
    _isUpdate = false;
    notifyListeners();
  }

  int get selectedPageNo => _selectedPageNo;
  int get onBoardingIndex => _onBoardingIndex;
  bool get isLoading => _isLoading;
  bool get isUpdate => _isUpdate;
  List<Map<String, dynamic>> get todoList => _todoList;
  List<Map<String, dynamic>> get completeTodoList => _completeTodoList;
  List<Map<String, dynamic>> get notCompleteTodoList => _notCompleteTodoList;
  List<Map<String, dynamic>> get notCompleteTodoSearchList =>
      _notCompleteTodoSearchList;
  List<Map<String, dynamic>> get completeTodoSearchList =>
      _completeTodoSearchList;
}
