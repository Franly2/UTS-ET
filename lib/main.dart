import 'package:flutter/material.dart';
import 'package:project_uts/class/user.dart';
import 'package:project_uts/screen/editProfile.dart';
import 'package:project_uts/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_uts/screen/home.dart';

User activeUser = User.empty();
String userEmail = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  activeUser = await checkUser();

  if (activeUser.email == '') {
    runApp(MaterialApp(home: Login(), debugShowCheckedModeBanner: false));
  } else {
    runApp(MyApp());
  }
}

Future<User> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  userEmail = prefs.getString("_user_email") ?? '';

  if (userEmail.isEmpty) {
    return User.empty();
  }

  User userData = User.getUserDataByEmail(userEmail);
  return userData;
}

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("_user_email");
  activeUser = User.empty();

  main();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project UTS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(title: 'UTS Emerging Technology'),
        '/login': (context) => Login(),
        '/logout': (context) {
          doLogout();
          return const Scaffold(body: Center(child: Text("Logging out...")));
        },
        '/editProfile': (context) => EditProfile(user: activeUser),
      },
      initialRoute: '/',
    );
  }
}
