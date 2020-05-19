import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class myStorage extends ChangeNotifier{
  List<myStorage> data=[];
  var timeStamp;
  var sender;
  var Filename;
  myStorage({this.timeStamp,this.sender,@required this.Filename});
  Future<void> getPackets(var IDoFRoom)async {
    data.clear();
    final _store = Firestore.instance;
    await for (var packets in _store.collection(IDoFRoom).snapshots()) {
      for(var packetdata in packets.documents){
        try{
          var timeStamp=int.parse(packetdata.data['timeStamp']);
          var sender=packetdata.data['sender'];
          var Filename=packetdata.data['fileName'];
          myStorage newClass=myStorage(timeStamp: timeStamp,sender: sender,Filename:Filename);
          data.add(newClass);
        }catch(e){}
      }
      if(_store!=null)
        break;
    }
    int length=data.length;
    myStorage temp=myStorage();
    for(int a=0;a<length;a++){
      for(int b=a;b<length;b++){
        if(data[a].timeStamp<data[b].timeStamp){
          temp=data[a];
          data[a]=data[b];
          data[b]=temp;
        }
      }
    }
//    notifyListeners();
  }
  notifyListeners();
}



class roomHandle extends ChangeNotifier{
  List<String> myRooms=[];

  void findRooms(BuildContext context)async{
    final _store=Firestore.instance;
    await for(var rooms in _store.collection(Provider.of<emails>(context,listen: false).UserEmail).snapshots()){
      for(var room in rooms.documents){
        myRooms.add(room.data['name']);
      }
      if(_store!=null){
        break;
      }
    }
    notifyListeners();
  }

  void addRoom(String s){
    myRooms.add(s);
    notifyListeners();
  }
}



var IDoFRoomStorage;


bool isInitialized=false;//fetchUploadFile



bool isSignedIn=false;//loginScreenFile



class emails extends  ChangeNotifier{
  String UserEmail;

  setemail(String s){
    this.UserEmail=s;
    notifyListeners();
  }
  removeEmail(){
    UserEmail='';
    notifyListeners();
  }


}


String userImage;


class room extends ChangeNotifier{
  String roomId;

  void setRoomId(String s){
    roomId=s;
    notifyListeners();
  }
}