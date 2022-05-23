import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/view/bottom_navbar.dart';
import 'package:todo_list/view/home_screen.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<String> imagesList = [
    'assets/ob1.jpg',
    'assets/ob2.jpg',
    'assets/ob3.jpg',
  ];
  //int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var toDoListVm = Provider.of<ToDoListViewModel>(context, listen: true);
    Widget onBoardItem({required String onBoardText}) => Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).size.height * .3),
          child: Column(
            children: [
              Image.asset(
                imagesList[toDoListVm.onBoardingIndex < 3
                    ? toDoListVm.onBoardingIndex
                    : 2],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Text(
                onBoardText,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        );
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView(
            controller: toDoListVm.onBoardPageController,
            onPageChanged: (v) {
              toDoListVm.onBoardingIndex = v;
              debugPrint("swap ${toDoListVm.onBoardingIndex}");
            },
            children: [
              onBoardItem(onBoardText: "Create your Task"),
              onBoardItem(onBoardText: "Easily Manage Task"),
              onBoardItem(onBoardText: "Ready to Start Your Day"),
            ],
          ),
          GestureDetector(
            onTap: () async {
              var storage = await SharedPreferences.getInstance();
              storage.setBool("isFirstTimeDoneOnBoarding", true);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavbar()),
                  (Route<dynamic> route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue),
                    child: Center(
                        child: Text(
                      "Skip",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imagesList.map((urlOfItem) {
                      int index = imagesList.indexOf(urlOfItem);
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: toDoListVm.onBoardingIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (toDoListVm.onBoardingIndex < 3) {
                        toDoListVm.onBoardingIndex++;
                        debugPrint("arrow ${toDoListVm.onBoardingIndex}");
                        toDoListVm.onBoardPageController
                            .jumpToPage(toDoListVm.onBoardingIndex);
                      }
                      ;
                      if (toDoListVm.onBoardingIndex == 3) {
                        var storage = await SharedPreferences.getInstance();
                        storage.setBool("isFirstTimeDoneOnBoarding", true);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavbar()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: const Center(
                          child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
