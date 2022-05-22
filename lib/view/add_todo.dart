import 'package:flutter/material.dart';
import 'package:todo_list/util/string_resources.dart';
import 'package:todo_list/util/text_style.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: widget.isUpdate
        //     ? GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: Icon(
        //           Icons.arrow_back_ios,
        //           color: Colors.black,
        //         ))
        //     : SizedBox(),
        centerTitle: true,
        title: Text(
          StringResources.addTodoListText,
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
                  //controller: titleController,
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
                  //controller: detailsController,
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
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xffB7D6B7),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  // widget.isUpdate ? "Update" :
                  StringResources.saveText,
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
