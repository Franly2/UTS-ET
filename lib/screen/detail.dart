import 'package:flutter/material.dart';
import 'package:project_uts/class/user.dart';

class Detail extends StatelessWidget {
  final User user;
  const Detail({super.key, required this.user});

  void _showAddFriendDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil Ditambahkan!'),
          content: Text(
              'Berhasil: ${user.nama} berhasil ditambahkan sebagai teman!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.getPicture), 
            ),
            const SizedBox(height: 16),
            Text(
              user.getName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'NRP: ${user.getNrp}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Program/Lab'),
              subtitle: Text(user.getProgram),
              leading: const Icon(Icons.school),
            ),
            const Divider(),
            ListTile(
              title: const Text('Biografi'),
              subtitle: Text(user.getBiografi, softWrap: true),
              leading: const Icon(Icons.info_outline),
              isThreeLine: true,
            ),
            const Divider(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddFriendDialog(context),
        icon: const Icon(Icons.person_add),
        label: const Text("Tambah Teman"),
      ),
    );
  }
}