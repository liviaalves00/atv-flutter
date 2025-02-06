import 'package:flutter/material.dart';
import 'package:projeto_final_fltter/src/controllers/contact_controller.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  ContactsViewState createState() => ContactsViewState();
}

class ContactsViewState extends State<ContactsView> {
  late ContactController _contactController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  void _addContact() {
    if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
      _contactController
          .addContact(
              _nameController.text,
              _phoneController.text,
              double.parse(_latController.text),
              double.parse(_lngController.text))
          .then((_) {
        if (mounted) {
          setState(() {});
        }
      });
      _nameController.clear();
      _phoneController.clear();
      _latController.clear();
      _lngController.clear();
    }
  }

  Future<void> _editContact(int id) async {
    final contacts = await _contactController.getContacts();
    late final contact;

    for (var _contact in contacts) {
      if (_contact.id == id) {
        contact = _contact;
        break;
      }
    }
    _nameController.text = contact.name;
    _phoneController.text = contact.phone;
    _latController.text = contact.lat.toString();
    _lngController.text = contact.lng.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Contato"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Nome")),
              TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: "Telefone")),
              TextField(
                  controller: _latController,
                  decoration: InputDecoration(labelText: "Latitude")),
              TextField(
                  controller: _lngController,
                  decoration: InputDecoration(labelText: "Longitude")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _contactController
                    .updateContact(
                        id,
                        _nameController.text,
                        _phoneController.text,
                        double.parse(_latController.text),
                        double.parse(_lngController.text))
                    .then((_) {
                  if (mounted) {
                    setState(() {});
                  }
                });
                Navigator.of(context).pop();
                _nameController.clear();
                _phoneController.clear();
                _latController.clear();
                _lngController.clear();
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(int id) async {
    _contactController.deleteContact(id).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _contactController = ContactController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Nome")),
                TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: "Telefone")),
                TextField(
                    controller: _latController,
                    decoration: InputDecoration(labelText: "Latitude")),
                TextField(
                    controller: _lngController,
                    decoration: InputDecoration(labelText: "Longitude")),
                ElevatedButton(
                  onPressed: _addContact,
                  child: Text("Adicionar Contato"),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _contactController.getContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Erro ao carregar contatos'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                } else {
                  final contacts = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        title: Text(contact.name),
                        subtitle: Text(contact.phone),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editContact(contact.id!),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteContact(contact.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
