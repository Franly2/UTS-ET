import 'package:flutter/material.dart';
import 'package:project_uts/class/user.dart';
import 'package:project_uts/data/userData.dart';
import 'package:project_uts/main.dart';
import 'package:project_uts/screen/detail.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<User> _allUsers = getUserData();
  late List<User> _filteredUsers;

  @override
  Widget build(BuildContext context) {
    final User currentUser = activeUser;
    _filteredUsers = List.from(_allUsers);
    _filteredUsers.removeWhere((user) => user.email == activeUser.email);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} - ${activeUser.getName}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: AppDrawer(activeUser: currentUser),
      body: ListView.builder(
        itemCount: _filteredUsers.length,
        itemBuilder: (context, index) {
          final user = _filteredUsers[index];
          return Mahasiswa(user: user);
        },
      ),
    );
  }
}

class Mahasiswa extends StatelessWidget {
  final User user;
  const Mahasiswa({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.getPicture),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.getName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('NRP: ${user.getNrp}'),
                      Text('Program: ${user.getProgram}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Detail(user: user)),
                  );
                },
                child: const Text('Lihat Detail Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final User activeUser;
  const AppDrawer({super.key, required this.activeUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(activeUser.getName),
            accountEmail: Text(activeUser.getEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(activeUser.getPicture),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Edit Profile"),
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.popAndPushNamed(context, "/editProfile");
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () {
              Navigator.popAndPushNamed(context, "/logout");
            },
          ),
        ],
      ),
    );
  }
}
