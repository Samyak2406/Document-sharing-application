import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docshelper/Screens/documentScreen.dart';
import 'package:docshelper/myStorage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

String randomIdGenerator() {
  String s = '';
  Random r = Random();
  for (int i = 0; i < 10; i++) {
    int temp = r.nextInt(10);
    s = s + temp.toString();
  }
  return s;
}

void makeServer(BuildContext context) async {
  String serverName;
  final _store = Firestore.instance;
  serverName = randomIdGenerator();
  while (await checkIfPresent(serverName)) {
    serverName = randomIdGenerator();
  }
  _store.collection('allRooms').add({'name': serverName});
  _store
      .collection(Provider.of<emails>(context,listen: false).UserEmail)
      .add({'name': serverName}); //TODO custom email
  myRooms.add(serverName);
  IDoFRoomStorage = serverName;
  Navigator.pushNamed(context, documentScreen.id);
}

Future<bool> checkIfPresent(String serverName) async {
  final _store = Firestore.instance;
  await for (var rooms in _store.collection('allRooms').snapshots()) {
    for (var room in rooms.documents) {
      if (room.data['name'] == serverName) {
        return true;
      }
    }
    break;
  }
  return false;
}

void joinServer(String serverName, BuildContext context) async {
  final _store = Firestore.instance;
  bool isPresent = await checkIfPresent(serverName);
  if (myRooms.contains(serverName)) {
    Fluttertoast.showToast(
        msg: "You have already joined server $serverName",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.blueGrey.shade900,
      textColor: Colors.green.shade200,
      gravity: ToastGravity.TOP
    );
  }
  else if (!isPresent) {
    Fluttertoast.showToast(
      msg: "Server with ID: $serverName does not exist",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.blueGrey.shade900,
      textColor: Colors.cyan,
      gravity: ToastGravity.TOP,
    );
  }
  else {
    _store.collection(Provider.of<emails>(context,listen: false).UserEmail).add({'name': serverName});
    myRooms.add(serverName);
    IDoFRoomStorage = serverName;
    Navigator.pop(context);
    Navigator.pushNamed(context, documentScreen.id);
  }
}
