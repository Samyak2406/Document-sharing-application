import 'package:docshelper/Google_SignIn.dart';
import 'package:docshelper/Screens/BlankPage.dart';
import 'package:docshelper/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'myStorage.dart';
import 'package:docshelper/Screens/documentScreen.dart';

class documentScreenDrawer extends StatefulWidget {
  @override
  _documentScreenDrawerState createState() => _documentScreenDrawerState();
}

class _documentScreenDrawerState extends State<documentScreenDrawer> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.black87,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CircleAvatar(
                            child: Image.network(userImage),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                " "+ Provider.of<emails>(context, listen: false)
                                    .UserEmail+" ",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blueGrey.shade900,
                  child: Center(
                    child: Text(
                      'My Rooms',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  color: Colors.blueGrey.shade900,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: ListView.builder(
//                      itemCount: myRooms.length,
                        itemCount: Provider.of<roomHandle>(context,listen: false).myRooms.length,
                      itemBuilder: (context, index) {
                        if(Provider.of<roomHandle>(context,listen: false).myRooms.length != 0) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    IDoFRoomStorage = Provider.of<roomHandle>(context,listen: false).myRooms[index];
                                    Provider.of<myStorage>(context,
                                            listen: false)
                                        .getPackets(IDoFRoomStorage);
                                    Provider.of<room>(context,listen: false).setRoomId(IDoFRoomStorage);
                                    Navigator.popUntil(
                                        context,
                                        (route) =>
                                            route.settings.name == BlankPage.id);
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.pushNamed(
                                        context, documentScreen.id);
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
                                        'Room:   ' + Provider.of<roomHandle>(context,listen:false).myRooms[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
