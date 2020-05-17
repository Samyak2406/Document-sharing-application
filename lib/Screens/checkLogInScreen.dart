import 'package:docshelper/Screens/loadingScreen.dart';
import 'package:docshelper/Screens/loginScreen.dart';
import 'package:docshelper/myStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class checkLogInScreen extends StatefulWidget {
  static const  id="checkLogInScreen.id";
  @override
  _checkLogInScreenState createState() => _checkLogInScreenState();
}

class _checkLogInScreenState extends State<checkLogInScreen> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  void nextScreen()async{
    final snapshot=await FirebaseAuth.instance.currentUser();
    if(snapshot!=null){
      String email=snapshot.email;
      Provider.of<emails>(context,listen: false).setemail(email);
//      print("Snapshot.email is $UserEmail");
      Navigator.pushNamedAndRemoveUntil(context, loadingScreen.id,(Route<dynamic> route) => false);
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, loginScreen.id,(Route<dynamic> route) => false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: true,
        child: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
