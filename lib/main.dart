import 'package:flutter/material.dart';
import 'user_list.dart'; // Import the user list widget from another file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(),// Set UserList widget as the home screen
    );
  }
}
