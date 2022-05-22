import 'package:flutter/material.dart';
import 'package:todo_list/util/colors.dart';
import 'package:todo_list/util/text_style.dart';

class ToDoListTile extends StatefulWidget {
  const ToDoListTile({Key? key}) : super(key: key);

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
                  Checkbox(value: true, onChanged: (v) {}),
                  Text(
                    "title",
                    style: CommonTextStyle.titleTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  //edit
                  GestureDetector(
                    onTap: () {},
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
              "details",
              style: CommonTextStyle.detailsTextStyle,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
