import 'dart:convert';

import 'package:employee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  Map idx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Delete'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Are You Sure To Delete ?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Center(
                child: RaisedButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                }),
              ),
              RaisedButton(onPressed: () {
                onDelete(idx);
              }),
            ],
          )
        ],
      ),
    );
  }

  void onDelete(Map employeeData) async {
    var res = await http.delete(
      "https://dev.xlayer.in/test/web/api/employee242?id=" + employeeData['id'],
    );
    print(res.body);
    try {
      Map resp = json.decode(res.body);
      if (resp['status']) {
        getdata();
      }
    } catch (e, s) {
      print(e.toString() + s.toString());
    }
  }
}

void getdata() {}
