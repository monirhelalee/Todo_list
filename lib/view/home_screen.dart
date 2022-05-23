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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: toDoListVm.notCompleteTodoSearchController,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                hintText: StringResources.searchHintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    )),
              ),
              onChanged: (v) {
                toDoListVm.getSearchResultNotCompletedToDoList(q: v);
              },
            ),
          ),
          Expanded(
            child: toDoListVm.isLoading
                ? const Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()),
                  )
                : toDoListVm.notCompleteTodoList.isEmpty ||
                        (toDoListVm.notCompleteTodoSearchController.text
                                .isNotEmpty &&
                            toDoListVm.notCompleteTodoSearchList.isEmpty)
                    ? const Center(
                        child: Text("No To-Do available"),
                      )
                    : ListView.builder(
                        itemCount: toDoListVm
                                .notCompleteTodoSearchController.text.isEmpty
                            ? toDoListVm.notCompleteTodoList.length
                            : toDoListVm.notCompleteTodoSearchList.length,
                        itemBuilder: (context, index) {
                          return ToDoListTile(
                            id: toDoListVm.notCompleteTodoSearchController.text
                                    .isEmpty
                                ? toDoListVm.notCompleteTodoList[index]["id"]
                                : toDoListVm.notCompleteTodoSearchList[index]
                                    ["id"],
                            title: toDoListVm.notCompleteTodoSearchController
                                    .text.isEmpty
                                ? toDoListVm.notCompleteTodoList[index]["title"]
                                : toDoListVm.notCompleteTodoSearchList[index]
                                    ["title"],
                            details: toDoListVm.notCompleteTodoSearchController
                                    .text.isEmpty
                                ? toDoListVm.notCompleteTodoList[index]
                                    ["details"]
                                : toDoListVm.notCompleteTodoSearchList[index]
                                    ["details"],
                            createdAt: toDoListVm
                                    .notCompleteTodoSearchController
                                    .text
                                    .isEmpty
                                ? toDoListVm.notCompleteTodoList[index]
                                    ["createdAt"]
                                : toDoListVm.notCompleteTodoSearchList[index]
                                    ["createdAt"],
                            isComplete: toDoListVm
                                    .notCompleteTodoSearchController
                                    .text
                                    .isEmpty
                                ? toDoListVm.notCompleteTodoList[index]
                                    ["isComplete"]
                                : toDoListVm.notCompleteTodoSearchList[index]
                                    ["isComplete"],
                          );
                        }),
          ),
        ],
      ),
    );
  }
}
