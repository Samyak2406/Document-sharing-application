import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'myStorage.dart';
import 'package:path_provider/path_provider.dart';

String getTimeStamp() {
  var temp = DateTime.now().millisecondsSinceEpoch.toString();
  return temp;
}

Future<File> getPdf(var IDoFRoom) async {
  //Opens the file asking user for permission
  try{
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'], //,'jpg','png'--docs may be in image format
    );
    return file;
//    uploadToFirebaseStorage(file,IDoFRoom,FileName);
  }
  catch(e){
    return null;
  }
}

Future<void> uploadToFirebaseStorage(File file,String FileName,BuildContext context) async {
  String IDoFRoom=IDoFRoomStorage;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String fileName = getTimeStamp();
  StorageReference _reference = await _storage.ref().child('${IDoFRoom}/' + fileName);
  await _reference.putFile(file);
  Firestore _store = Firestore.instance;
  _store
      .collection(IDoFRoom)
      .add({'sender': Provider.of<emails>(context,listen: false).UserEmail, 'timeStamp': fileName,'fileName':FileName});
}

Future<void> getDownloadurl(String roomName,int index)async{
  try{
    FirebaseStorage _storage=FirebaseStorage.instance;
    StorageReference reference=await _storage.ref().child(roomName+'/'+data[index].timeStamp.toString());
    String url=await reference.getDownloadURL();
    downloadFile(url);
  }
  catch(e){}
}

void downloadFile(String url) async {
  var status = await Permission.storage.status;
  if(status.isUndetermined || status.isDenied){
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
  if(status.isPermanentlyDenied || status.isRestricted){
    openAppSettings();
  }
  if(status.isGranted){

    if(isInitialized==false){
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );
    isInitialized=true;
  }

    var fileSave =  await _findLocalPath();//+Platform.pathSeparator + 'Download';
    print("filesave is $fileSave");
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: fileSave,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    final tasks = await FlutterDownloader.loadTasks();
    await FlutterDownloader.open(taskId: taskId);
    Fluttertoast.showToast(msg: 'File downloaded at $fileSave');
//    HttpClient client =  HttpClient();
//    var _downloadData = List<int>();
//    var fileSave =  File(await _findLocalPath());
//    print("$fileSave --is path");
//    client.getUrl(
//        Uri.parse(url))
//        .then((HttpClientRequest request) {
//      return request.close();
//    }).then((HttpClientResponse response) {
//      response.listen((d) => _downloadData.addAll(d),
//          onDone: () {
//            fileSave.writeAsBytes(_downloadData);
//            Fluttertoast.showToast(msg: 'File downloaded at $fileSave');
//            print("'File downloaded at $fileSave'");
//          }
//      );
//    });
  }
}

Future<String> _findLocalPath() async {
  final directory=await DownloadsPathProvider.downloadsDirectory;
  return directory.path ;//+'/docshelper${getTimeStamp()}.pdf';
}


String refineName(String text){
  if(text==null){
    return "File_";
  }
  String refined='';
  for(int i=0;i<text.length;i++){
    int temp=text.codeUnitAt(i);
    String general='AaZz';
    if((temp>general.codeUnitAt(1) && temp>general.codeUnitAt(3))||(temp>general.codeUnitAt(0) && temp>general.codeUnitAt(2))){
      refined+=text[i];
    }
  }
  if(refined.length<3){
    return 'File_';
  }
  return refined;
}