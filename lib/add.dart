import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  BuildContext _context;
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_context == null) {
      _context = context;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text('Enter New Id'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'First Name'),
                controller: firstName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Last Name'),
                controller: lastName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Phone Numer'),
                controller: phoneNumber,
                maxLength: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Email (optional)'),
                controller: email,
              ),
            ),
            RaisedButton.icon(
                color: Colors.amber[700],
                onPressed: () {
                  onSubmit();
                },
                icon: Icon(
                  Icons.assignment,
                  color: Colors.white,
                ),
                label: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
            )
          ],
        ),
      ),
    );
  }

  onSubmit() async {

    Object jsonBody = {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'phoneNumber': phoneNumber.text,
      'email': email.text,
      'countryCode': 91,
    };
    print(jsonBody);

    var res = await http.post(
      "https://dev.xlayer.in/test/web/api/employee242",
      body: json.encode(jsonBody),
    );
    print(res.body);
    try {
      Map resp = json.decode(res.body);
      if (resp['status']) {
        Navigator.pop(context);
      }
    } catch (e, s) {
      print(e.toString() + s.toString());
    }
  }
}
