import 'package:docshelper/Screens/BlankPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docshelper/myStorage.dart';

class loadingScreen extends StatefulWidget {
  static const id='loadingScreen';

  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  void initState() {
    super.initState();
    loadRooms();
  }

  void loadRooms()async{
    myRooms=[];
    final _store=Firestore.instance;
    await for(var rooms in _store.collection(UserEmail).snapshots()){//TODO add user email
      for(var room in rooms.documents){
        myRooms.add(room.data['name']);
      }
      break;
    }
    Navigator.pushNamedAndRemoveUntil(context, BlankPage.id,(Route<dynamic> route) => false);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          Text('Internet...'),
        ],
      ),
    );
  }
}