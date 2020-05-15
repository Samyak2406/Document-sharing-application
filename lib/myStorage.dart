import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
List<myStorage> data=[];

class myStorage extends ChangeNotifier{
  var timeStamp;
  var sender;
  myStorage({this.timeStamp,this.sender});
  void getPackets(var IDoFRoom)async {
    data.clear();
    print('getPackets called');
    final _store = Firestore.instance;
    await for (var packets in _store.collection(IDoFRoom).snapshots()) {
      for(var packetdata in packets.documents){
        print('${packetdata.data['sender']}');
        try{
          var timeStamp=int.parse(packetdata.data['timeStamp']);
          var sender=packetdata.data['sender'];
          myStorage newClass=myStorage(timeStamp: timeStamp,sender: sender);
          data.add(newClass);
        }catch(e){print('exception');}
      }
      break;
    }
    print('Length of listData  '+data.length.toString());
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
    for(int i=0;i<length;i++) {
      print(data[i].timeStamp);
    }
  }
  notifyListeners();
}



List<String> myRooms=[];



var IDoFRoomStorage;//TODO--


bool isInitialized=false;//fetchUploadFile



bool isSignedIn=false;//loginScreenFile