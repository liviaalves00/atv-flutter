import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class ContactController extends ChangeNotifier {
  List<ContactModel> _contacts = [];

  List<ContactModel> get contacts => _contacts;

  void addContact(String name, String phone) {
    _contacts.add(ContactModel(name: name, phone: phone));
    notifyListeners();
  }

  void removeContact(ContactModel contact) {
    _contacts.remove(contact);
    notifyListeners();
  }
}
