import 'package:contacts/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class ContactData extends ChangeNotifier{
  static const String _boxName = "contactBox";

  List<Contact> _contacts = [];
  Contact _activeContact;

  void getContacts() async{
    var box = await Hive.openBox(_boxName);
    _contacts.clear();
    box.values.forEach((element) {
      _contacts.add(element);
    });
    print('contacts: ${_contacts.length}');
    print('Hive: ${box.values.length}');
    notifyListeners();
  }

  Contact getContact(index){
    return _contacts[index];
  }

  void addContact(Contact contact) async{
    var box = await Hive.openBox(_boxName);
    _contacts.clear();
    await box.add(contact);

    box.values.forEach((element) {
      _contacts.add(element);
    });

    notifyListeners();

  }

  void deleteContact(key) async{
    var box = await Hive.openBox(_boxName);

    _contacts.clear();
    await box.delete(key);

    box.values.forEach((element) {
      _contacts.add(element);
    });

    notifyListeners();
    print("Deleted");
  }

  void editContact({Contact contact, int contactKey}) async{
    var box = await Hive.openBox(_boxName);

    _contacts.clear();
    await box.put(contactKey, contact);
    box.values.forEach((element) {
      _contacts.add(element);
    });

    _activeContact = box.get(contactKey);

    notifyListeners();
    print("efited");
  }

  void setActiveContact(key) async{
    var box = await Hive.openBox(_boxName);

    _activeContact = box.get(key);

    notifyListeners();
  }

  Contact getActiveContact() => _activeContact;

  int get contacsCount => _contacts.length;
}