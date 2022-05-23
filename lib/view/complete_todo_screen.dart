import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/util/colors.dart';
import 'package:todo_list/util/string_resources.dart';
import 'package:todo_list/util/text_style.dart';
import 'package:todo_list/view/widgets/todo_list_tile.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class CompleteToDoScreen extends StatefulWidget {
  const CompleteToDoScreen({Key? key}) : super(key: key);

  @override
  State<CompleteToDoScreen> createState() => _CompleteToDoScreenState();
}

class _CompleteToDoScreenState extends State<CompleteToDoScreen> {
  @override
  void initState() {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      await toDoListVm.getCompletedToDoList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: true);
    return Scaffold(
      backgroundColor: CommonColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CommonColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          StringResources.completedTdoListText,
          style: CommonTextStyle.appBarTextStyle,
        ),
      ),
      body: toDoListVm.isLoading
          ? const CircularProgressIndicator()
          : toDoListVm.notCompleteTodoList.isEmpty
              ? const Center(
                  child: Text("No completed To-Do available"),
                )
              : ListView.builder(
                  itemCount: toDoListVm.completeTodoList.length,
                  itemBuilder: (context, index) {
                    return ToDoListTile(
                      id: toDoListVm.completeTodoList[index]["id"],
                      title: toDoListVm.completeTodoList[index]["title"],
                      details: toDoListVm.completeTodoList[index]["details"],
                      createdAt: toDoListVm.completeTodoList[index]
                          ["createdAt"],
                      isComplete: toDoListVm.completeTodoList[index]
                          ["isComplete"],
                    );
                  }),
    );
  }
}
