import '../constants.dart';
import 'file:///C:/Users/NanoTech/Desktop/mercikala/mercikala/contacts/lib/provider/contact_data.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactEditPage extends StatefulWidget {
  final Contact currentContact;

  const ContactEditPage({Key key, this.currentContact});

  @override
  _ContactEditPageState createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  String newName;
  String newPhone;
  String newEmail;

  void _editContact() {
    if (newName == null) {
      toastWidget("Give entry a name");
      return;
    }
    if (newName.length < 2) {
      toastWidget("Get a longer name");
      return;
    }
    Provider.of<ContactData>(context, listen: false).editContact(
        contact: Contact(
            name: newName, email: newEmail ?? "", phone: newPhone ?? "0"),
        contactKey: widget.currentContact.key);
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.currentContact.name;
    newName = widget.currentContact.name;

    _emailController.text = widget.currentContact.email;
    newEmail = widget.currentContact.email;

    _phoneController.text = widget.currentContact.phone;
    newPhone = widget.currentContact.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 16.0,
        title: Text(
          "Edit ${widget.currentContact.name}",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.blue,
              ),
              onPressed: () => _editContact())
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
                onChanged: (name){
                  setState(() {
                    newName = name;
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
                onChanged: (phone){
                  setState(() {
                    newPhone = phone;
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
                onChanged: (email){
                  setState(() {
                    newEmail = email;
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
