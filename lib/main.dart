import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/contact_list_screen.dart';
import 'providers/contact_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MaterialApp(
        title: 'Contato App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactListScreen(),
      ),
    );
  }
}
