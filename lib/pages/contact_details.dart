import 'package:contacts/provider/contact_data.dart';

import '../constants.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/contact_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactData>(builder: (context, contactData, child) {
      Contact currentContact = contactData.getActiveContact();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 16.0,
          title: Text(
            currentContact?.name,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.create, color: Colors.blue,),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ContactEditPage(currentContact: currentContact)))),
            IconButton(icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: () => _deleteConfirmation(currentContact)),
          ],
        ),

        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getItem(title: "Phone", name: currentContact?.phone??"", color: Colors.grey[300]),
               // getItem(title: "Join Date", name: DateFormat("yyyy-mm-dd").format(currentContact.joinDate), color: Colors.grey[300]),
                getItem(title: "Email", name: currentContact?.email??"", color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _deleteConfirmation(currentContact) {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Are you sure?",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('You are about to delete ${currentContact.name}'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("this action cannot be undone")
                ],
              ),
            ),
            actions: [
              FlatButton(onPressed: () {
                print("deleted");
                Provider.of<ContactData>(context, listen: false).deleteContact(
                    currentContact.key);
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              }, child: Text(
                'Delete',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                ),
              )),
              FlatButton(onPressed: () {
                print("cancelling");
                Navigator.pop(context);
              }, child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),
              ))
            ],
          );
        }
    );
  }

  Widget getItem({String title, String name, Color color}){
    return Container(
      height: 36.0,
      color: color,
      child: Row(
        children: [
          Text(title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0
            ),),
          Text(name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0
            ),)
        ],
      ),
    );
  }
}

