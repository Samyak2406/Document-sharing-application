import 'dart:io';
import 'package:docshelper/documentScreenDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../fetchUpload.dart';
import '../myStorage.dart';

String text;
File file;

class documentScreen extends StatefulWidget {
  static const id = 'documentScreen';
  @override
  _documentScreenState createState() => _documentScreenState();
}

class _documentScreenState extends State<documentScreen> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    text=null;
    file=null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('docs_Helper-$IDoFRoomStorage')),
        backgroundColor: Colors.grey.shade900,
      ),
      drawer: documentScreenDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => popUpScreen());
        },
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
          color: Colors.grey.shade300,
          ),
          child: listview(data, () async {
            //Callback function
            await Future.delayed(Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
            await Provider.of<myStorage>(context, listen: false)
                .getPackets(IDoFRoomStorage);
            setState(() {
              data;
            });
          }, _refreshController),
        ),
      ),
    );
  }
}

class listview extends StatelessWidget {
  RefreshController _refreshController;
  List<myStorage> data;
  Function callback;
  listview(this.data, this.callback, this._refreshController);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: callback,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 10),
                child: GestureDetector(
                  onTap: () async {
//                    print(index);
                    await getDownloadurl(IDoFRoomStorage, index);
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(30)),
                          color: Colors.grey.shade800,
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          data[index].Filename.toString(),
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
final textController=TextEditingController();
class popUpScreen extends StatefulWidget {
  @override
  _popUpScreenState createState() => _popUpScreenState();
}

class _popUpScreenState extends State<popUpScreen> {
  @override
  void initState() {
    super.initState();
    if(text!=null){
      textController.value=TextEditingValue(text: text);
    }
  }
  void getText(){
    if(text!=null){
      textController.value=TextEditingValue(text: text);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue.shade900,
          Colors.blue.shade400,
          Colors.cyan,
          Colors.cyanAccent,
          Colors.white
        ],
      )),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: FittedBox(
                  child: Text(
                    'Upload File',
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 40),
                  ),
                ),
              ),
              color: Colors.indigo.shade500,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.cyanAccent,
                            Colors.cyan,
                            Colors.blue,
                            Colors.indigo
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            hintText: "File Name",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (newValue) {
                            text = newValue;
                          },
                          textAlign: TextAlign.center,
                          autofocus: true,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                Center(
                  child: FittedBox(
                    child: GestureDetector(
                      onTap: () async{
                        file=null;
                        try{
                          file=await getPdf(IDoFRoomStorage);
                        }catch(e){}
                        finally{
                          getText();
                          setState(() {
                            file;
                            text=null;
                          });
                        }
                      },
                      child: FittedBox(
                        child: Container(
                          child: Center(
                            child: ListTile(
                              leading: file==null?Icon(Icons.cancel):Icon(Icons.check),
                              title: Text(
                                'Attach  File',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.indigo.shade900),
                              ),
                            ),
                          ),
                          height: 60,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: LinearGradient(
                              colors: [Colors.yellow, Colors.green],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        text =  refineName(text);
//                        print("refined is $text");
                        if(file!=null){
                          await uploadToFirebaseStorage(file,text,context);
                          file=null;
                          text=null;
                          Navigator.pop(context);
                        }
                        else{
                          Fluttertoast.showToast(msg: 'Please select a file first');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightGreen.shade400,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          height: 50,
                          width: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}