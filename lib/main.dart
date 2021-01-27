import 'dart:convert';

import 'package:employee_app/add.dart';
import 'package:employee_app/delete.dart';
import 'package:employee_app/edit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BuildContext _context;
  List<Map> employeeDataList = [];

  Future<void> getdata() async {
    var res = await http.get(
      "https://dev.xlayer.in/test/web/api/employee242",
      // body: jsonEncode(
      //   {
      //     "task": "Edit"
      //   },
      // ),
      // headers: {"content-type": "application/json"},
    );
    print(res.body);
    try {
      employeeDataList = [];
      Map resp = json.decode(res.body);
      if (!resp['status']) {
        for (int i = 0; i < resp['result'].length; i++) {
          Map idx = resp['result'][i];
          employeeDataList.add(idx);
        }
      }
      setState(() {});
    } catch (e, s) {
      print(e.toString() + s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_context == null) {
      _context = context;
      getdata();
    }

    return Scaffold(
      drawer: Drawer(
        child: AppBar(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text('ID Chart'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getdata();
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Container(
          child: ListView.builder(
            itemCount: employeeDataList.length,
            itemBuilder: (context, position) {
              Map idx = employeeDataList[position];
              return Card(
                child: InkWell(
                  onTap: () {
                    print(idx.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditEmployee(
                          employeeData: idx,
                          onResponse: () {
                            print('on_response');
                            getdata();
                          },
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Delete()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 40,
                            ),
                            Text(
                              'Full name : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              idx['firstName'],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              idx['lastName'],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 40,
                            ),
                            Text(
                              'Phone : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              idx['phoneNumber'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 40,
                            ),
                            Text(
                              'Email : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              idx['email'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[800],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add()));
        },
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
