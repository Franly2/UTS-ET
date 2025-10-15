import 'package:flutter/material.dart';
import 'package:project_uts/class/user.dart';
import 'package:project_uts/screen/editProfile.dart';
import 'package:project_uts/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

User _active_user = User.empty();
String _user_email = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _active_user = await checkUser();
  if (_active_user.email == '') {
    runApp(MyLogin());
  } else {
    runApp(MyAppWrapper());
  }
}

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("_user_email");
  _active_user = User.empty();
  main();
}

Future<User> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  _user_email = prefs.getString("_user_email") ?? '';
  if (_user_email == '') {
    return User.empty();
  }
  User userData = User.getUserDataByEmail(_user_email);
  return userData;
}

class MyAppWrapper extends StatefulWidget {
  @override
  State<MyAppWrapper> createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project UTS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'UTS Emerging Technology'),
        '/login': (context) => Login(),
        '/logout': (context) {
          doLogout();
          return Login();
        },
        '/editProfile': (context) => EditProfile(user: _active_user),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("${_active_user.getName}"),
              accountEmail: Text("${_active_user.getEmail}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
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
              leading: const Icon(Icons.logout),
              onTap: () {
                Navigator.popAndPushNamed(context, "/logout");
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('tes', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
