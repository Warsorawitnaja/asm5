import 'package:asm5/page/todo.dart';
import 'package:asm5/page/todo_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        leading: Icon(
          Icons.check_box,
          color: Colors.white,
        ),
        title: Text('My ToDo'),
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Container(margin: EdgeInsets.all(8)),
                    for (ToDo todoo in todoList)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDo,
                      ),
                  ],
                ))
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: 'Enter new ToDo',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20.0,
                      right: 20.0,
                    ),
                    child: TextButton(
                      onPressed: () {
                        _addToDo(_todoController.text);
                      },
                      child: const Text(
                        'ADD',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDo(String todoText) {
    setState(() {
      todoList.removeWhere((item) => item.todoText == todoText);
    });
  }

  void _addToDo(String todo) {
    setState(() {
      todoList.add(ToDo(todoText: todo));
    });
    _todoController.clear();
  }
}
