import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docshelper/documentScreenDrawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../fetchUpload.dart';
import '../myStorage.dart';


class documentScreen extends StatefulWidget {
  static const id = 'documentScreen';
  @override
  _documentScreenState createState() => _documentScreenState();
}

class _documentScreenState extends State<documentScreen> {

  @override
  void initState() {
    super.initState();

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
          getPdf(IDoFRoomStorage);
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
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print(index);
                      await getDownloadurl(IDoFRoomStorage, index);//TODO --
                    },
                    child: Text(
                      data[index].timeStamp.toString(),
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}