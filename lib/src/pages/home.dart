import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/src/pages/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> items = [
    Band(id: '1', name: 'test1', votes: 0),
    Band(id: '2', name: 'test2', votes: 0),
    Band(id: '3', name: 'test3', votes: 0),
    Band(id: '4', name: 'test4', votes: 0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Band names',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: addNewBand,
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return bandTile(items[index]);
            }));
  }

  Widget bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print(direction);
      },
      background: Align(
        child: Container(
          padding: EdgeInsets.only(left: 20.0),
          alignment: Alignment.centerLeft,
          color: Colors.red,
          child: Text(
            'Delete band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            band.name.substring(0, 2),
          ),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20.0)),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (!Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                textColor: Colors.blue,
                child: Text('add'),
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('New band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      setState(() {
        items.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      });
    }
    Navigator.pop(context);
  }
}
