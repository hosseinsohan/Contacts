import 'file:///C:/Users/NanoTech/Desktop/mercikala/mercikala/contacts/lib/provider/contact_data.dart';
import 'package:contacts/widgets/ContactTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index){
          return ContactTile(
            tileIndex: index
          );
        },
      itemCount: Provider.of<ContactData>(context)
      .contacsCount,
      padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
    );
  }
}
