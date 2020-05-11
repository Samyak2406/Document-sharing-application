import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docshelper/documentScreenDrawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

var IDoFRoom = 'IDoFRoom';

class documentScreen extends StatelessWidget {
  static const id = 'documentScreen';

  String getTimeStamp() {
    var temp = DateTime.now().millisecondsSinceEpoch.toString();
    return temp;
  }

  Future<void> getPdf() async {
    //Opens the file asking user for permission
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'], //,'jpg','png'--docs may be in image format
    );
    uploadToFirebaseStorage(file);
  }

  Future<void> uploadToFirebaseStorage(File file) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    String fileName = getTimeStamp();
    StorageReference _refernce =
        await _storage.ref().child('$IDoFRoom/' + fileName);
    StorageUploadTask uploadTask = await _refernce.putFile(file);
    Firestore _store = Firestore.instance;
    _store
        .collection(IDoFRoom)
        .add({'sender': 'abc@gmail.com', 'timeStamp': fileName});//TODO add custom email
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
          getPdf();
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