import 'package:docshelper/Screens/documentScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docshelper/myStorage.dart';

class loadingScreen extends StatefulWidget {
  static const id='loadingScreen';

  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  void initState() {
    super.initState();
    getPackets();
  }

  void getPackets()async {
    data=[];
    final _store = Firestore.instance;
    await for (var packets in _store.collection('IDoFRoom').snapshots()) { //TODO add custom id
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
    Navigator.pushNamedAndRemoveUntil(context, documentScreen.id,(Route<dynamic> route) => false);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}