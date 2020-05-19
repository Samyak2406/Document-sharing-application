import 'package:docshelper/Screens/checkLogInScreen.dart';
import 'package:docshelper/myStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      create: (context)=>roomHandle(),
      child: ChangeNotifierProvider(
        create: (context)=>myStorage(),
        child: ChangeNotifierProvider(
          create: (context)=>emails(),
          child: ChangeNotifierProvider(
            create: (context)=>room(),
            child: MaterialApp(
              initialRoute: checkLogInScreen.id,
              routes: (
              {
                checkLogInScreen.id:(context)=>checkLogInScreen(),
                BlankPage.id:(context) => BlankPage(),
                loadingScreen.id:(context)=>loadingScreen(),
                loginScreen.id:(context)=>loginScreen(),
                documentScreen.id:(context)=>documentScreen()
              }
              ),
            ),
          ),
        ),
      ),
    );
  }
}