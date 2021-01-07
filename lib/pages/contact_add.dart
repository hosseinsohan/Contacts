import 'package:contacts/models/contact.dart';
import 'package:contacts/provider/contact_data.dart';
import 'package:contacts/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  String name;
  String phone;
  String email;

  void _addContact() {
    if (name == null) {
      toastWidget("Give entry a name");
      return;
    }
    if (name.length < 2) {
      toastWidget("Get a longer name");
      return;
    }
    Provider.of<ContactData>(context, listen: false).addContact(
        Contact(
            name: name, email: email ?? "", phone: phone ?? "0"),
        );
    Navigator.pop(context);
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 16.0,
        title: Text(
          "Add Contact",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
              ),
              onPressed: () {
                _addContact();
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "name"
                ),
                onChanged: (value){
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: "phone"
                ),
                onChanged: (value){
                  setState(() {
                    phone = value;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "email"
                ),
                onChanged: (value){
                  setState(() {
                    email = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
