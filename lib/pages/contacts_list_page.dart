import 'package:contacts/provider/contact_data.dart';

import '../constants.dart';
import 'package:contacts/widgets/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ContactData>(context, listen: false).getContacts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 16.0,
        title: Text('contacts',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0
        ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container(child: ContactsList(),)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        tooltip: "add",
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addContactPage'),
      ),
    );
  }
}
