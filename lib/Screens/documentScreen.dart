import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docshelper/documentScreenDrawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../fetchUpload.dart';
import '../myStorage.dart';


class documentScreen extends StatefulWidget {
   var IDoFRoom;
  static const id = 'documentScreen';
  @override
  _documentScreenState createState() => _documentScreenState();
}

class _documentScreenState extends State<documentScreen> {

  @override
  void initState() {
    widget.IDoFRoom=IDoFRoomStorage;
    super.initState();
    getPackets(widget.IDoFRoom);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('docs_Helper'),
        backgroundColor: Colors.indigo,
      ),
      drawer: documentScreenDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        child: Icon(Icons.add),
        onPressed: () {
          getPdf(widget.IDoFRoom);
        },
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
           decoration: BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topLeft,
             end: Alignment.bottomRight,
             colors: [Colors.cyan.shade800,Colors.cyan.shade600,Colors.cyan.shade400,Colors.lightGreen.shade300],
             ),
           ),
        ),
      ),
    );
  }
}