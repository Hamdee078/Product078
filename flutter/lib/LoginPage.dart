import 'package:flutter/material.dart';
import 'package:flutter1/HomePage.dart';
import 'package:flutter1/models/user_model.dart';
import 'package:flutter1/pages/UserPage/view/UserPage.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_service.dart';
import 'providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = usernameController.text;
      final password = passwordController.text;
      print('Username: $username, Password: $password');

      try {
        final result = await AuthService().login(username, password);

        if (result['success']) {
          UserModel authResponse = result['message'];

          if (!mounted) return;
          Provider.of<UserProvider>(context, listen: false).onLogin(authResponse);

          print('Login successful. Welcome, ${authResponse.user.name}');
          print('Access Token: ${authResponse.accessToken}');
          print('Refresh Token: ${authResponse.refreshToken}');
          print('Role: ${authResponse.role}');

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00BFFF), // เปลี่ยนสีพื้นหลังเป็นสีฟ้า
              Color(0xFF87CEEB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar with gradient
            Container(
              child: AppBar(
                title: Text('Login Page'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Username TextField with Icon
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Password TextField with Icon
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Fancy Login Button
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color.fromARGB(255, 37, 28, 211),
                          shadowColor: Colors.black,
                          elevation: 5,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}