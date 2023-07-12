import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grocery_list_bloc.dart';
import 'grocery_list_screen.dart';
//import 'package:disposing/disposing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final groceryListBloc = GroceryListBloc();

  @override
  Widget build(BuildContext context) {
    groceryListBloc.loadList(); // Load the grocery list from shared preferences

    return MaterialApp(
      title: 'Grocery List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => groceryListBloc,
        child: GroceryListScreen(),
      ),
    );
  }

  // @override
  // void dispose() {
  //   groceryListBloc.close(); // Dispose of the grocery list bloc
  //   super.dispose();
  // }
}
