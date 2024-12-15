import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactProvider with ChangeNotifier {
  final List<Contact> _contacts = [];

  List<Contact> get contacts => List.unmodifiable(_contacts);

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void editContact(Contact oldContact, Contact newContact) {
    final index = _contacts.indexOf(oldContact);
    if (index != -1) {
      _contacts[index] = newContact;
      notifyListeners();
    }
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }
}
