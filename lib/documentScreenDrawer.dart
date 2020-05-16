import 'package:docshelper/Google_SignIn.dart';
import 'package:docshelper/Screens/BlankPage.dart';
import 'package:docshelper/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myStorage.dart';
import 'package:docshelper/Screens/documentScreen.dart';

class documentScreenDrawer extends StatefulWidget {
  @override
  _documentScreenDrawerState createState() => _documentScreenDrawerState();
}

class _documentScreenDrawerState extends State<documentScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey.shade900,
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            UserEmail,//TODO--custom email
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        signOutGoogle();
                        Navigator.pushNamedAndRemoveUntil(context, loginScreen.id, (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.blueGrey.shade900,
                         child: Center(
                           child: Text(
                             'Sign Out',
                             style: TextStyle(
                               fontSize: 20,
                               color: Colors.grey,
                             ),
                           ),
                         ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.blueGrey.shade900,
                child: ListView.builder(
                  itemCount: myRooms.length,
                  itemBuilder: (context, index) {
                    if (myRooms.length != 0) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () async {
                                IDoFRoomStorage = myRooms[index];
                                await Provider.of<myStorage>(context, listen: false)
                                    .getPackets(IDoFRoomStorage);
                                Navigator.pushNamedAndRemoveUntil(context, BlankPage.id,
                                    (Route<dynamic> route) => false);
                                Navigator.pushNamed(context, documentScreen.id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.blueGrey,
                                ),
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Room:   ' + myRooms[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
