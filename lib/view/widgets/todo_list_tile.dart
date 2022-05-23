import 'package:flutter/material.dart';
import 'package:todo_list/util/colors.dart';
import 'package:todo_list/util/text_style.dart';
import 'package:todo_list/view/add_todo_screen.dart';

class ToDoListTile extends StatefulWidget {
  final int? id;
  final String? title;
  final String? details;
  final String? createdAt;
  final bool? isUpdate;
  const ToDoListTile({
    Key? key,
    this.id,
    this.title,
    this.details,
    this.isUpdate,
    this.createdAt,
  }) : super(key: key);

  @override
  State<ToDoListTile> createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 10, bottom: 10),
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
                  Checkbox(value: true, onChanged: (v) {}),
                  Text(
                    widget.title ?? "",
                    style: CommonTextStyle.titleTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  //edit
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddToDoScreen(
                                    details: widget.details,
                                    title: widget.details,
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
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(5),
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
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Text(
              widget.details ?? "",
              style: CommonTextStyle.detailsTextStyle,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
