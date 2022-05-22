import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/util/string_resources.dart';
import 'package:todo_list/view/bottom_navbar.dart';
import 'package:todo_list/view/home_page.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ToDoListViewModel>(
            create: (context) => ToDoListViewModel()),
      ],
      child: MaterialApp(
        title: StringResources.todoListText,
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const BottomNavbar(),
      ),
    );
  }
}
