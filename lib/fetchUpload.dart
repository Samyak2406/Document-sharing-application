import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'myStorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';


String getTimeStamp() {
  var temp = DateTime.now().millisecondsSinceEpoch.toString();
  return temp;
}

Future<void> getPdf(var IDoFRoom) async {
  //Opens the file asking user for permission
  try{
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'], //,'jpg','png'--docs may be in image format
    );
    uploadToFirebaseStorage(file,IDoFRoom);
  }
  catch(e){}
}

Future<void> uploadToFirebaseStorage(File file, var IDoFRoom) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  String fileName = getTimeStamp();
  StorageReference _reference = await _storage.ref().child('${IDoFRoom}/' + fileName);
  StorageUploadTask uploadTask = await _reference.putFile(file);
  Firestore _store = Firestore.instance;
  _store
      .collection(IDoFRoom)
      .add({'sender': 'abc@gmail.com', 'timeStamp': fileName});//TODO add custom email
}

Future<void> getDownloadurl(String roomName,int index)async{
  try{
    FirebaseStorage _storage=FirebaseStorage.instance;
    StorageReference reference=await _storage.ref().child(roomName+'/'+data[index].timeStamp.toString());
    print('qwer     '+roomName+'/'+data[index].timeStamp.toString());
    String url=await reference.getDownloadURL();
    print(url + 'is the url');
    downloadFile(url);
  }
  catch(e){}
}

void downloadFile(String url) async {
  HttpClient client =  HttpClient();
  var _downloadData = List<int>();
  var fileSave =  File(await _findLocalPath());
  client.getUrl(
      Uri.parse(url))
      .then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) {
    response.listen((d) => _downloadData.addAll(d),
        onDone: () {
          fileSave.writeAsBytes(_downloadData);
        }
    );
  });
}

Future<String> _findLocalPath() async {
  final directory = await getExternalStorageDirectory();
  print('zxcvbnm    '+directory.path);
  return directory.path +'/docshelper${getTimeStamp()}.pdf';
}