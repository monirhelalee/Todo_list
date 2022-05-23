import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/util/colors.dart';
import 'package:todo_list/util/string_resources.dart';
import 'package:todo_list/util/text_style.dart';
import 'package:todo_list/view/widgets/todo_list_tile.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      await toDoListVm.getNotCompletedToDoList();
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
          StringResources.todoListText,
          style: CommonTextStyle.appBarTextStyle,
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: toDoListVm.titleController,
            maxLines: 1,
            maxLength: 20,
            decoration: InputDecoration(
              filled: true,
              hintText: StringResources.titleHintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  )),
            ),
          ),
          toDoListVm.isLoading
              ? const CircularProgressIndicator()
              : toDoListVm.notCompleteTodoList.isEmpty
                  ? const Center(
                      child: Text("No To-Do available"),
                    )
                  : ListView.builder(
                      itemCount: toDoListVm.notCompleteTodoList.length,
                      itemBuilder: (context, index) {
                        return ToDoListTile(
                          id: toDoListVm.notCompleteTodoList[index]["id"],
                          title: toDoListVm.notCompleteTodoList[index]["title"],
                          details: toDoListVm.notCompleteTodoList[index]
                              ["details"],
                          createdAt: toDoListVm.notCompleteTodoList[index]
                              ["createdAt"],
                          isComplete: toDoListVm.notCompleteTodoList[index]
                              ["isComplete"],
                        );
                      }),
        ],
      ),
    );
  }
}
