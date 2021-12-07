import 'package:flutter/material.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Todo',
          style: TextStyle(
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
                trailing: TextButton(
                  child: Icon(
                    Icons.remove_circle_outline,
                    size: 25,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Нужно сделать...'),
                    content: (TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5,
                              style: BorderStyle.solid),
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
                    )),
                    actions: [
                      TextButton(
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
        child: Icon(
          Icons.add_circle,
          size: 50,
        ),
      ),
    );
  }
}
