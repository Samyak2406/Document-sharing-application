import 'package:docshelper/documentScreenDrawer.dart';
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
      floatingActionButton: FloatingActionButton(
        //TODO --Create a new Room
        child: Icon(Icons.add),
        backgroundColor: Colors.green.shade700,
      ),
      drawer: documentScreenDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow,Colors.orangeAccent],
          ),
        ),
      ),
    );
  }
}