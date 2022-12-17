import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/view/bottom_navbar.dart';
import 'package:todo_list/view/onboarding_screen.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late bool isFirstTimeDoneOnBoarding;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var storage = await SharedPreferences.getInstance();
      isFirstTimeDoneOnBoarding =
          storage.getBool("isFirstTimeDoneOnBoarding") ?? false;
      debugPrint("isOnboading $isFirstTimeDoneOnBoarding");
      if (isFirstTimeDoneOnBoarding) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavbar()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
