// lib/screen/editProfile.dart
// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_super_parameters, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_uts/class/user.dart';
import 'package:project_uts/main.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late String selectedProgram;
  List<String> programOptions = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Desain Komunikasi Visual',
    'Teknik Komputer',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.nama);
    bioController = TextEditingController(text: widget.user.biografi);
    selectedProgram = widget.user.program;
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void saveAndClose() async {
    User updatedUser = User(
      nameController.text,
      widget.user.nrp,
      selectedProgram,
      bioController.text,
      widget.user.picture,
      widget.user.email,
      widget.user.password,
    );

    User.saveChanges(updatedUser);
    activeUser = updatedUser;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil!'),
          content: const Text('Data berhasil diperbarui.'),
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
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Lengkap'),
            const SizedBox(height: 6),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama lengkap',
              ),
            ),
            const SizedBox(height: 12),
            Text('Program/Lab'),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedProgram,
                underline: const SizedBox(),
                items: programOptions.map((p) {
                  return DropdownMenuItem<String>(value: p, child: Text(p));
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      selectedProgram = val;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 12),
            Text('Biografi'),
            const SizedBox(height: 6),
            TextField(
              controller: bioController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Biografi anda',
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveAndClose,
                    child: const Text('Simpan Perubahan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
