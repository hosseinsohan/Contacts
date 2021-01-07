import 'package:contacts/provider/contact_data.dart';

import '../constants.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/contact_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactTile extends StatelessWidget {
  final int tileIndex;

  const ContactTile({Key key, this.tileIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactData>(builder: (context, contactData, child) {
      Contact currentContact = contactData.getContact(tileIndex);

      return Container(

          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: mainColor,
              child: Text(
                currentContact.name.substring(0, 1) ?? "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              currentContact?.name ?? "",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Text(
                  currentContact?.phone.toString() ?? "",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Divider()
              ],
            ),
            onTap: () {
              Provider.of<ContactData>(context, listen: false).setActiveContact(currentContact.key);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ContactDetailsPage()
              ));
            },
          ));
    });
  }
}
