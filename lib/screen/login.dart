// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_uts/main.dart';
import 'package:project_uts/service/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _user_email = "";
String _user_password = "";

void doLogin(BuildContext context) async {
  bool login = loginService(_user_email, _user_password);

  if (!login) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login gagal! Email atau password salah.')),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  prefs.setString("_user_email", _user_email);

  Navigator.of(
    context,
  ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  main();
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 350,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1),
              color: Theme.of(context).cardColor,
              boxShadow: const [BoxShadow(blurRadius: 5)],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com',
                    ),
                    onChanged: (value) => _user_email = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                    ),
                    onChanged: (value) => _user_password = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        doLogin(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
