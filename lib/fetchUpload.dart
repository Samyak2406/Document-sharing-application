import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'myStorage.dart';

void getPackets(var IDoFRoom)async {
  data=[];
  final _store = Firestore.instance;
  await for (var packets in _store.collection(IDoFRoom).snapshots()) {
    for(var packetdata in packets.documents){
      var timeStamp=int.parse(packetdata.data['timeStamp']);
      var sender=packetdata.data['sender'];
      myStorage newClass=myStorage(timeStamp: timeStamp,sender: sender);
      data.add(newClass);
    }
    break;
  }
  int length=data.length;
  myStorage temp=myStorage();
  //Sort--
  for(int a=0;a<length;a++){
    for(int b=a;b<length;b++){
      if(data[a].timeStamp<data[b].timeStamp){
        temp=data[a];
        data[a]=data[b];
        data[b]=temp;
      }
    }
  }//data is ready time-wise to be shown...
  for(int i=0;i<length;i++){
    print(data[i].timeStamp);
  }
}



String getTimeStamp() {
  var temp = DateTime.now().millisecondsSinceEpoch.toString();
  return temp;
}

Future<void> getPdf(var IDoFRoom) async {
  //Opens the file asking user for permission
  File file = await FilePicker.getFile(
    type: FileType.custom,
    allowedExtensions: ['pdf'], //,'jpg','png'--docs may be in image format
  );
  uploadToFirebaseStorage(file,IDoFRoom);
}

Future<void> uploadToFirebaseStorage(File file, var IDoFRoom) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  String fileName = getTimeStamp();
  StorageReference _refernce =
  await _storage.ref().child('${IDoFRoom}/' + fileName);
  StorageUploadTask uploadTask = await _refernce.putFile(file);
  Firestore _store = Firestore.instance;
  _store
      .collection(IDoFRoom)
      .add({'sender': 'abc@gmail.com', 'timeStamp': fileName});//TODO add custom email
}