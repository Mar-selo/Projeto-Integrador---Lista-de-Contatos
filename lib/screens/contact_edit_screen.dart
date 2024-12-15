import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/contact.dart';
import '../providers/contact_provider.dart';

class ContactEditScreen extends StatefulWidget {
  final Contact contact;

  const ContactEditScreen({Key? key, required this.contact}) : super(key: key);

  @override
  _ContactEditScreenState createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.contact.name;
    _phone = widget.contact.phone;
    _email = widget.contact.email;
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedContact = Contact(name: _name, phone: _phone, email: _email);

      if (widget.contact.name.isEmpty &&
          widget.contact.phone.isEmpty &&
          widget.contact.email.isEmpty) {
        Provider.of<ContactProvider>(context, listen: false)
            .addContact(updatedContact);
      } else {
        Provider.of<ContactProvider>(context, listen: false)
            .editContact(widget.contact, updatedContact);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Contato'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveContact,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome.';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um telefone.';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um e-mail.';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
