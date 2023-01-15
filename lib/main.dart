import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/repos/repositories.dart';
import 'package:user/screen/OneUser_Screen.dart';
import 'package:user/screen/userList_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: UserList(),
      ),
      routes: {
        OneUser.routeName: (context) => RepositoryProvider(
              create: (context) => UserRepository(),
              child: OneUser(),
            ),
      },
    );
  }
}
