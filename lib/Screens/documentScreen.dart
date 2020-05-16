import 'package:docshelper/documentScreenDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../fetchUpload.dart';
import '../myStorage.dart';

String text;

class documentScreen extends StatefulWidget {
  static const id = 'documentScreen';
  @override
  _documentScreenState createState() => _documentScreenState();
}

class _documentScreenState extends State<documentScreen> {
  @override
  void initState() {
    super.initState();
    print('init is called');
    for (var i in data) {
      print('Hurray---' + i.timeStamp.toString());
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
          showModalBottomSheet(
              context: context,isScrollControlled: true, builder: (context) => popUpScreen());
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
              colors: [
                Colors.cyan.shade800,
                Colors.cyan.shade600,
                Colors.cyan.shade400,
                Colors.lightGreen.shade300
              ],
            ),
          ),
          child: listview(data, () async {
            //Callback function
            await Future.delayed(Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
            await Provider.of<myStorage>(context, listen: false)
                .getPackets(IDoFRoomStorage);
            for (var i in data) {
              print('data is $i');
            }
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
                    print(index);
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
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade50,
                            Colors.grey.shade200,
                            Colors.grey.shade600
                          ]),
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          data[index].Filename.toString(),
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.black87,
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

class popUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
       gradient: LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
           colors: [Colors.blue.shade900,Colors.blue.shade400,Colors.cyan,Colors.cyanAccent,Colors.white],
       )
     ),

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
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 40
                    ),
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
                            gradient: LinearGradient(
                            colors: [Colors.cyanAccent,Colors.cyan,Colors.blue,Colors.indigo]
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextField(
                            onChanged: (newValue){
                              text=newValue;
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
                      onTap: (){
                        if(text==null){
                            text='001';}
                        text=refineName(text);
                        print(text);
                        getPdf(IDoFRoomStorage,text);
                      },
                      child: FittedBox(
                        child: Container(
                          child: Center(
                            child: Text(
                              '   Add  File   ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.indigo.shade900
                              ),
                            ),
                          ),
                          height:60,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: LinearGradient(
                              colors: [Colors.yellow,Colors.green],
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
        ],
      ),
    );
  }
}
