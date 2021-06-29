import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todo_1/functs/funcs.dart';

class Home extends StatefulWidget {
  final ListStorage storage;
  const Home({Key? key, required this.storage}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;
  List todoList = [];

  @override
  void initState() {
    super.initState();
    widget.storage.readList().then((value) {
      setState(() {
        for (var item in value) {
          todoList.add(item);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(
        centerTitle: true,
        title: NeumorphicText(
          'My Todo',
          style: NeumorphicStyle(
            depth: 7, //customize depth here
            color: Colors.black, //customize color here
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 18, //customize size here
            // AND others usual text style properties (fontFamily, fontWeight, ...)
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(
              child: ListTile(
                title: Text(todoList[index]),
                tileColor: Colors.white10,
                trailing: NeumorphicButton(
                  child: NeumorphicIcon(
                    Icons.remove_circle_outline,
                    size: 25,
                    style: NeumorphicStyle(depth: 19, color: Colors.black),
                  ),
                  style: NeumorphicStyle(
                    depth: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      todoList.removeAt(index);
                      widget.storage.writeList(todoList);
                    });
                  },
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
                widget.storage.writeList(todoList);
              });
            },
          );
        },
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Нужно сделать...'),
                    content: Neumorphic(
                      child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (String value) {
                          _userToDo = value;
                        },
                      ),
                    ),
                    actions: [
                      NeumorphicButton(
                          onPressed: () {
                            setState(() {
                              todoList.add(_userToDo);
                              widget.storage.writeList(todoList);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Добавить'))
                    ]);
              });
        },
        child: NeumorphicIcon(
          Icons.add_circle,
          size: 50,
          style: NeumorphicStyle(depth: 3),
        ),
      ),
    );
  }
}
