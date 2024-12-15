import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';
import '../models/contact.dart';
import 'contact_edit_screen.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  void _confirmDelete(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Contato'),
        content: const Text('Tem certeza que deseja excluir este contato?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ContactProvider>(context, listen: false)
                  .removeContact(contact);
              Navigator.of(ctx).pop();
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<ContactProvider>(context).contacts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
      ),
      body: contacts.isEmpty
          ? const Center(child: Text('Nenhum contato adicionado.'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (ctx, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(context, contact),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ContactEditScreen(contact: contact),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactEditScreen(
                contact: Contact(name: '', phone: '', email: ''),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
