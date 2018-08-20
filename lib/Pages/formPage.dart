import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sample_list/helpers.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => new _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var emailController = new TextEditingController();
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var textController = new TextEditingController();

  Future _chooseDate(BuildContext context) async {
    var now = new DateTime.now();
    var initialDate = now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      textController.text = result.day.toString() +
          '/' +
          result.month.toString() +
          '/' +
          result.year.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          new ListTile(
            contentPadding:
                EdgeInsets.only(left: 15.0, bottom: 10.0, right: 15.0),
            leading: const Icon(Icons.today),
            title: new TextField(
              controller: textController,
              decoration: new InputDecoration(
                hintText: "Birthday",
                enabled: false,
              ),
            ),
            onTap: () => _chooseDate(context),
          ),
          const Divider(
            height: 1.0,
          ),
          new FloatingActionButton.extended(
            icon: new Icon(Icons.add_call),
            label: const Text('Submit'),
            onPressed: () {
              if (phoneController.text.isEmpty ||
                  nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  textController.text.isEmpty) {
             Helpers().getToast('All fields are required'); 
              } else {
                if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(emailController.text)) {
                  Helpers().getToast('Submitted successfully');    
                } else {
                   Helpers().getToast('Please enter valid email');  
                }
              }
            },
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0))),
          ),
        ],
      ),
    );
  }
}
