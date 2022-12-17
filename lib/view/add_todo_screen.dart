import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/util/string_resources.dart';
import 'package:todo_list/util/text_style.dart';
import 'package:todo_list/view/bottom_navbar.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class AddToDoScreen extends StatefulWidget {
  final int? id;
  final String? title;
  final String? details;
  final bool isUpdate;
  const AddToDoScreen(
      {Key? key, this.id, this.title, this.details, this.isUpdate = false})
      : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: false);
    if (!widget.isUpdate) {
      toDoListVm.reset();
    }
    if (widget.isUpdate) {
      toDoListVm.titleController.text = widget.title!;
      if (widget.details != null) {
        toDoListVm.descriptionController.text = widget.details!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.isUpdate
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ))
            : const SizedBox(),
        centerTitle: true,
        title: Text(
          widget.isUpdate
              ? StringResources.updateTodoListText
              : StringResources.addTodoListText,
          style: CommonTextStyle.appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringResources.titleText,
                  style: CommonTextStyle.levelTextStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: toDoListVm.titleController,
                  maxLines: 1,
                  maxLength: 40,
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringResources.descriptionText,
                  style: CommonTextStyle.levelTextStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: toDoListVm.descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: StringResources.detailsHintText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                if (toDoListVm.titleController.text.trim().isNotEmpty) {
                  widget.isUpdate
                      ? toDoListVm.updateTodo(widget.id!)
                      : toDoListVm.addNewTodo();
                  BotToast.showText(
                      text: widget.isUpdate
                          ? "To-Do update successfully!"
                          : "To-Do add successfully!");

                  toDoListVm.titleController.clear();
                  toDoListVm.descriptionController.clear();
                  if (widget.isUpdate) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const BottomNavbar()),
                        (Route<dynamic> route) => false);
                  }
                  if (!widget.isUpdate) {
                    toDoListVm.selectedPageNo = 0;
                  }
                } else {
                  BotToast.showText(text: "Title required!");
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xffB7D6B7),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  widget.isUpdate
                      ? StringResources.updateText
                      : StringResources.saveText,
                  style: CommonTextStyle.buttonTextStyle,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
