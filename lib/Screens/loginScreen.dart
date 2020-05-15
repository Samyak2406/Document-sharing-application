import 'package:docshelper/Google_SignIn.dart';
import 'package:docshelper/Screens/BlankPage.dart';
import 'package:docshelper/myStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  static const id='loginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
              colors: [Colors.yellowAccent,Colors.lightGreen,Colors.cyan]
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  try{
                    signInWithGoogle();
                    if(isSignedIn==true){
                      Navigator.pushNamedAndRemoveUntil(context, BlankPage.id, (Route<dynamic> route)=>false);
                    }
                  }
                  catch(e){}
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/google.png'),
                ),
              ),
              Center(
                child: Text(
                  'Sign in to proceed',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                    fontSize: 35
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}