import 'package:projeto_final_fltter/src/models/contact_model.dart';
import 'package:projeto_final_fltter/src/repositories/contact_repository.dart';

class ContactController {
  late ContactRepository contactRepository;

  ContactController() {
    contactRepository = ContactRepository();
  }

  Future<void> addContact(
      String name, String phone, double lat, double lng) async {
    final contact = Contact(name: name, phone: phone, lat: lat, lng: lng);
    await contactRepository.insertContact(contact);
  }

  Future<List<Contact>> getContacts() async {
    return await contactRepository.contacts();
  }

  Future<void> updateContact(
      int id, String name, String phone, double lat, double lng) async {
    final contact =
        Contact(id: id, name: name, phone: phone, lat: lat, lng: lng);
    await contactRepository.updateContact(contact);
  }

  Future<void> deleteContact(int id) async {
    await contactRepository.deleteContact(id);
  }
}
