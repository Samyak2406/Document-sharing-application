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
        backgroundColor: Colors.black87,
      ),
      drawer: documentScreenDrawer(),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade300),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: FittedBox(
                      child: Text('Version 0.2'),
                    ),
                  ),
                ],
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
                  color: Colors.black87,
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
      color: Colors.cyanAccent.shade100.withOpacity(0.4),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
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
                          color: Colors.blue.shade700,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.indigo.shade700),
                      onChanged: (newText) {
                        serverName = newText;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    joinServer(serverName, context);
                  },
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      child: Center(
                        child: Text(
                          'JOIN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      height: 40,
                      width: 40,
                      color: Colors.blue.shade600,
                    ),
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
