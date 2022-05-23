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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: toDoListVm.completeTodoSearchController,
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
                toDoListVm.getSearchResultCompletedToDoList(q: v);
              },
            ),
          ),
          Expanded(
            child: toDoListVm.isLoading
                ? const Center(
                  child: SizedBox(
                      height: 30, width: 30, child: CircularProgressIndicator()),
                )
                : toDoListVm.completeTodoList.isEmpty ||
                        (toDoListVm
                                .completeTodoSearchController.text.isNotEmpty &&
                            toDoListVm.completeTodoSearchList.isEmpty)
                    ? const Center(
                        child: Text("No completed To-Do available"),
                      )
                    : ListView.builder(
                        itemCount:
                            toDoListVm.completeTodoSearchController.text.isEmpty
                                ? toDoListVm.completeTodoList.length
                                : toDoListVm.completeTodoSearchList.length,
                        itemBuilder: (context, index) {
                          return ToDoListTile(
                            id: toDoListVm
                                    .completeTodoSearchController.text.isEmpty
                                ? toDoListVm.completeTodoList[index]["id"]
                                : toDoListVm.completeTodoSearchList[index]
                                    ["id"],
                            title: toDoListVm
                                    .completeTodoSearchController.text.isEmpty
                                ? toDoListVm.completeTodoList[index]["title"]
                                : toDoListVm.completeTodoSearchList[index]
                                    ["title"],
                            details: toDoListVm
                                    .completeTodoSearchController.text.isEmpty
                                ? toDoListVm.completeTodoList[index]["details"]
                                : toDoListVm.completeTodoSearchList[index]
                                    ["details"],
                            createdAt: toDoListVm
                                    .completeTodoSearchController.text.isEmpty
                                ? toDoListVm.completeTodoList[index]
                                    ["createdAt"]
                                : toDoListVm.completeTodoSearchList[index]
                                    ["createdAt"],
                            isComplete: toDoListVm
                                    .completeTodoSearchController.text.isEmpty
                                ? toDoListVm.completeTodoList[index]
                                    ["isComplete"]
                                : toDoListVm.completeTodoSearchList[index]
                                    ["isComplete"],
                          );
                        }),
          ),
        ],
      ),
    );
  }
}
