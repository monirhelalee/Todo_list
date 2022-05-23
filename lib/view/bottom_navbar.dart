import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/util/colors.dart';
import 'package:todo_list/view/add_todo_screen.dart';
import 'package:todo_list/view/complete_todo_screen.dart';
import 'package:todo_list/view/home_screen.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  void initState() {
    //Provider.of<ToDoListViewModel>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: true);
    return Scaffold(
      body: toDoListVm.selectedPageNo == 0
          ? const HomeScreen()
          : toDoListVm.selectedPageNo == 1
              ? const AddToDoScreen()
              : const CompleteToDoScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toDoListVm.selectedPageNo = 1;
        },
        child: Icon(
          Icons.add,
          color: toDoListVm.selectedPageNo == 1
              ? CommonColors.listBackgroundColor
              : Colors.yellow[800],
          size: 40,
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .15,
                right: MediaQuery.of(context).size.width * .15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    toDoListVm.selectedPageNo = 0;
                  },
                  child: Icon(
                    Icons.list_rounded,
                    size: 35,
                    color: toDoListVm.selectedPageNo == 0
                        ? CommonColors.listBackgroundColor
                        : Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    toDoListVm.selectedPageNo = 2;
                  },
                  child: Icon(
                    Icons.checklist_rounded,
                    size: 35,
                    color: toDoListVm.selectedPageNo == 2
                        ? CommonColors.listBackgroundColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
