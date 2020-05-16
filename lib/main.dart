import 'package:docshelper/myStorage.dart';
import 'package:flutter/material.dart';
import 'package:docshelper/Screens/loadingScreen.dart';
import 'package:docshelper/Screens/documentScreen.dart';
import 'package:docshelper/Screens/loginScreen.dart';
import 'package:provider/provider.dart';
import 'Screens/BlankPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>myStorage(),
      child: MaterialApp(
        initialRoute: loginScreen.id,
        routes: (
        {
          BlankPage.id:(context) => BlankPage(),
          loadingScreen.id:(context)=>loadingScreen(),
          loginScreen.id:(context)=>loginScreen(),
          documentScreen.id:(context)=>documentScreen()
        }
        ),
      ),
    );
  }
}