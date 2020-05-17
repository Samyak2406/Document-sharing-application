import 'package:docshelper/Google_SignIn.dart';
import 'package:docshelper/Screens/BlankPage.dart';
import 'package:docshelper/Screens/loadingScreen.dart';
import 'package:docshelper/myStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class loginScreen extends StatefulWidget {
  static const id = 'loginScreen';

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topCenter,
                  colors: [Colors.yellowAccent, Colors.lightGreen, Colors.cyan]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    heightFactor: 0.3,
                    child: FittedBox(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/google.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Powered by Google',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontSize: 35),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FractionallySizedBox(
                      heightFactor: 0.6,
                      widthFactor: 0.4,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            showSpinner=true;
                          });
                          try {
                            await signInWithGoogle(context);
                            if (isSignedIn == true) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  loadingScreen.id,
                                      (Route<dynamic> route) => false);
                            }
                          } catch (e) {}
                          setState(() {
                            showSpinner=false;
                          });
                        },
                        child: Container(
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                'Proceed',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.green.shade900,
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.shade700.withOpacity(0.45),
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}