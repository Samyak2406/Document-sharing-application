import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'myStorage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

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
//  for(int i=0;i<length;i++){
//    print(data[i].timeStamp);
//  }
}



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
    print('buzz1');
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
  print('buzz2');
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
//    final http.Response downloadData=await http.get(url);
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
  })
      .then((HttpClientResponse response) {
    response.listen((d) => _downloadData.addAll(d),
        onDone: () {
          fileSave.writeAsBytes(_downloadData);
        }
    );
  });
}

//void downloadFile(String url)async{
//  if(isInitialized==false){
//    await FlutterDownloader.initialize(
//        debug: true // optional: set false to disable printing logs to console
//    );
//    isInitialized=true;
//  }
//
//  var _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
//  final taskId = await FlutterDownloader.enqueue(
//    url: url,
//    savedDir: await _findLocalPath(),
//    showNotification: true, // show download progress in status bar (for Android)
//    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//  );
//  final tasks = await FlutterDownloader.loadTasks();
//  await FlutterDownloader.open(taskId: taskId);
//}


Future<String> _findLocalPath() async {
  final directory = await getExternalStorageDirectory();
  print('zxcvbnm    '+directory.path);
  return directory.path +'/docshelper${getTimeStamp()}.pdf';
}