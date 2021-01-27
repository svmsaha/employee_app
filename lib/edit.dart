import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditEmployee extends StatefulWidget {

  Map employeeData;
  Function onResponse;
  EditEmployee({this.employeeData, this.onResponse});

  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {

  BuildContext _context;
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();

  _EditEmployeeState();

  @override
  Widget build(BuildContext context) {
    if (_context == null) {
      _context = context;
      loadData();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Edit employee details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'First name'),
              controller: firstName,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Last name'),
              controller: lastName,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Phone number'),
              controller: phoneNumber,
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Email (optional)'),
              controller: email,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton.icon(
              onPressed: () {
                onSubmit();
              },
              color: Colors.green[600],
              icon: Icon(
                Icons.assignment,
                color: Colors.white,
              ),
              label: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loadData() {
    print('load_data_edit_page: ' + widget.employeeData.toString());
    firstName.text = widget.employeeData['firstName'];
    lastName.text = widget.employeeData['lastName'];
    phoneNumber.text = widget.employeeData['phoneNumber'].toString().replaceAll('91', '');
    email.text = widget.employeeData['email'];
  }


  onSubmit() async {

    Object jsonBody = {
      'id': widget.employeeData['id'],
      'firstName': firstName.text,
      'lastName': lastName.text,
      'phoneNumber': phoneNumber.text,
      'email': email.text,
      'countryCode': 91,
    };
    print(jsonBody);

    var res = await http.put(
      "https://dev.xlayer.in/test/web/api/employee242",
      body: json.encode(jsonBody),
    );
    print(res.body);
    try {
      Map resp = json.decode(res.body);
      if (resp['status']) {
        widget.onResponse.call();
        Navigator.pop(context);
      }
    } catch (e, s) {
      print(e.toString() + s.toString());
    }
  }

}
