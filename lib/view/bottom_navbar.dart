import 'package:flutter/material.dart';
import 'package:todo_list/view/add_todo.dart';
import 'package:todo_list/view/home_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddToDo(),
      //HomePage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color:
              //selectedPageNo == 1 ? Color(0xffB7D6B7) :
              Colors.yellow[800],
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
                  onTap: () {},
                  child: Icon(
                    Icons.list_rounded,
                    size: 35,
                    color:
                        //selectedPageNo == 0 ? Color(0xffB7D6B7) :
                        Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.checklist_rounded,
                    size: 35,
                    color:
                        //selectedPageNo == 2 ? Color(0xffB7D6B7) :
                        Colors.black,
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
