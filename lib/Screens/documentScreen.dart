import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

var IDoFRoom='IDoFRoom';

class documentScreen extends StatelessWidget {
  static const id = 'documentScreen';

  String getTimeStamp(){
     var temp=DateTime.now().millisecondsSinceEpoch.toString();
    return temp;
  }
  Future<void> getPdf() async {//Opens the file asking user for permission
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],//,'jpg','png'--docs may be in image format
    );
    uploadToFirebaseStorage(file);
  }

  Future<void> uploadToFirebaseStorage(File file)async {
    FirebaseStorage _storage=FirebaseStorage.instance;
    String fileName=getTimeStamp();
    StorageReference _refernce=await _storage.ref().child('$IDoFRoom/'+fileName);
    StorageUploadTask uploadTask=await _refernce.putFile(file);
    Firestore _store=Firestore.instance;
    _store.collection(IDoFRoom).add(
        {
          'sender':'abc@gmail.com',
          'timeStamp':fileName
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            getPdf();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }
}