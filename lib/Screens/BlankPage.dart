import 'package:docshelper/documentScreenDrawer.dart';
import 'package:docshelper/serverFile.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  static const id = 'BlankPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('docs_Helper'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: documentScreenDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.orangeAccent],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            makeBox('Make a server', () {
              makeServer(context);
            }),
            makeBox('Join a server', () {
              joinScreen(context);
            }),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: FittedBox(
                    child: Text('Version 0.1'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class makeBox extends StatelessWidget {
  Function callback;
  String text;
  makeBox(this.text, this.callback);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: callback,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.indigo, width: 5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Widget> joinScreen(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => joinPopUp());
}

class joinPopUp extends StatelessWidget {
  String serverName = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent.shade100,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter room id:',
                      hintStyle: TextStyle(
                        color: Colors.yellow.shade700,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.indigo.shade700),
                    onChanged: (newText) {
                      serverName = newText;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    joinServer(serverName, context);
                  },
                  child: Container(
                    child: Center(child: Text('JOIN')),
                    height: 40,
                    width: 40,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
