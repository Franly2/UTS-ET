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
  String selectedProgram = 'Teknik Informatika';
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
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void saveAndClose() {
    User currentUser = widget.user;

    currentUser.nama = nameController.text;
    currentUser.program = selectedProgram;
    currentUser.biografi = bioController.text;
    User.saveChanges(currentUser);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profil')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Lengkap'),
            SizedBox(height: 6),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama lengkap',
              ),
            ),
            SizedBox(height: 12),
            Text('Program/Lab'),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedProgram,
                underline: SizedBox(),
                items: programOptions.map((p) {
                  // ini untuk loop setiap item di list programOptions sama kayak foreach
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
            SizedBox(height: 12),
            Text('Biografi'),
            SizedBox(height: 6),
            TextField(
              controller: bioController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Biografi anda',
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text('Batal'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      saveAndClose();
                    },
                    child: Text('Simpan Perubahan'),
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
