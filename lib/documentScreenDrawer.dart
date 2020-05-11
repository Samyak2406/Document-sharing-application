import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'myStorage.dart';
import 'package:docshelper/Screens/documentScreen.dart';

class documentScreenDrawer extends StatefulWidget {
  @override
  _documentScreenDrawerState createState() => _documentScreenDrawerState();
}

class _documentScreenDrawerState extends State<documentScreenDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueGrey.shade900,
        child: ListView.builder(
          itemCount: myRooms.length,
          itemBuilder: (context, index) {
            if (myRooms.length != 0) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        IDoFRoomStorage=myRooms[index];
                        Navigator.pushNamedAndRemoveUntil(context, documentScreen.id,(Route<dynamic> route) => false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10),),
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
    );
  }
}
