import 'auth_service.dart';
import 'package:flutter/material.dart'; 
import 'util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}
class _NotesPageState extends State<NotesPage> {
final _noteController = TextEditingController();
final _auth = FirebaseAuth.instance;


@override
void initState() {
  super.initState();
  _createUserDocIfNotExists();
}
Future<void> _createUserDocIfNotExists() async {
  final uid = _auth.currentUser?.uid;
  if (uid == null) return;

  final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
  final docSnapshot = await userDocRef.get();

  if (!docSnapshot.exists) {
    await userDocRef.set({
      'createdAt': FieldValue.serverTimestamp(),
      'email': _auth.currentUser?.email,
    });
  }
}
CollectionReference get notesCollection {
  final uid = _auth.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('notes');
}

Future<void> _addNote() async {
  final text = _noteController.text.trim();
  if (text.isEmpty) return;
  await notesCollection.add({
    'text': text,
    'createdAt': FieldValue.serverTimestamp(),
  });
  _noteController.clear();
}
Future<void> _deleteNote(String noteId) async {
  await notesCollection.doc(noteId).delete();
}
Future<void> _logout() async {
  await _auth.signOut();
  Navigator.pushReplacementNamed(context, '${MyRoutes.login}');
}
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("My Notes"),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _logout,
        ),
      ],
    ),

    // Floating + button
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Add Note"),
              content: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: "Write a note...",
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addNote();
                    Navigator.pop(context); // close dialog
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    ),

    body: Column(
      children: [
        // Notes list
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: notesCollection
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final notes = snapshot.data!.docs;

              if (notes.isEmpty) {
                return const Center(child: Text("No notes yet"));
              }

              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  final noteText = note['text'] ?? '';
                  return Card(
                    child: ListTile(
                      title: Text(noteText),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNote(note.id),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
}