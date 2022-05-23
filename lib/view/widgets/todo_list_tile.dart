import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/util/colors.dart';
import 'package:todo_list/util/text_style.dart';
import 'package:todo_list/view/add_todo_screen.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class ToDoListTile extends StatefulWidget {
  final int id;
  final String? title;
  final String? details;
  final String? createdAt;
  final bool? isUpdate;
  final String? isComplete;
  const ToDoListTile({
    Key? key,
    required this.id,
    this.title,
    this.details,
    this.isUpdate,
    this.createdAt,
    this.isComplete,
  }) : super(key: key);

  @override
  State<ToDoListTile> createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {
  @override
  Widget build(BuildContext context) {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: true);
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: CommonColors.listBackgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //check box
                  Checkbox(
                      value: widget.isComplete == "t" ? true : false,
                      onChanged: (v) async {
                        if (v != null) {
                          await toDoListVm
                              .completeTodo(
                                  id: widget.id,
                                  title: widget.title ?? "",
                                  isComplete: v ? "t" : "f",
                                  details: widget.details ?? "")
                              .then((value) =>
                                  toDoListVm.getNotCompletedToDoList())
                              .then(
                                  (value) => toDoListVm.getCompletedToDoList());
                        }
                        if (toDoListVm
                            .completeTodoSearchController.text.isEmpty) {
                          toDoListVm.getSearchResultCompletedToDoList(
                              q: toDoListVm.completeTodoSearchController.text);
                        }
                        if (toDoListVm
                            .notCompleteTodoSearchController.text.isEmpty) {
                          toDoListVm.getSearchResultNotCompletedToDoList(
                              q: toDoListVm
                                  .notCompleteTodoSearchController.text);
                        }
                      }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title ?? "",
                        style: widget.isComplete == "f"
                            ? CommonTextStyle.titleTextStyle
                            : CommonTextStyle.titleTextWithLineThroughStyle,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Colors.yellow,
                        ),
                        child: Text(
                          "Created at: ${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.createdAt ?? ""))}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    //edit
                    widget.isComplete == "t"
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddToDoScreen(
                                            details: widget.details,
                                            title: widget.title,
                                            id: widget.id,
                                            isUpdate: true,
                                          )));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(Icons.edit_outlined)),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    //delete
                    GestureDetector(
                      onTap: () async {
                        await toDoListVm
                            .deleteTodo(id: widget.id)
                            .then(
                                (value) => toDoListVm.getNotCompletedToDoList())
                            .then((value) => toDoListVm.getCompletedToDoList());
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Text(
                widget.details ?? "",
                style: widget.isComplete == "f"
                    ? CommonTextStyle.detailsTextStyle
                    : CommonTextStyle.detailsWithLineThroughTextStyle,
                softWrap: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
