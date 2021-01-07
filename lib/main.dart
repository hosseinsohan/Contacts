import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/contact_add.dart';
import 'package:contacts/pages/contacts_list_page.dart';
import 'package:contacts/provider/contact_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Hive.registerAdapter(ContactAdapter());
  Provider.debugCheckInvalidValueType = null;
  runApp(ContactApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
}

class ContactApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
     create: (_) => ContactData(),

      child: MaterialApp(
          title: 'Contacts App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            "/": (context) => FutureBuilder(
                future: _initHive(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print('done');
                    if (snapshot.error!=null) {
                      print('error');
                      return Container(
                        child: Center(
                            child: Text(
                                "Error establishing connection to database")),
                      );
                    } else {
                      print("ok");
                      return ContactsListPage();
                    }
                  } else {
                    return Scaffold(
                      body: Container(),
                    );
                  }
                }),
            '/addContactPage': (_) => AddContactPage()
          },
      ),
    );
  }
}
