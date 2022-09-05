import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceheight;
  late double _devicewidth;

  String? _newTaskContent;
  Box? _box;

  _HomePageState();
  @override
  Widget build(BuildContext context) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceheight * 0.13,
        title: const Text(
          "Taskly!",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
        future: Hive.openBox('tasks'),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.connectionState == ConnectionState.done) {
            _box = _snapshot.data;
            return _taskList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            "Cook Food!",
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: const Icon(
            Icons.check_box_outlined,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text("Add Task !"),
            content: TextField(
              onSubmitted: (_value) {},
              onChanged: (_value) {
                setState(() {
                  _newTaskContent = _value;
                });
              },
            ),
          );
        });
  }
}
