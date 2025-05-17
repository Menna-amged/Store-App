import 'package:flutter/material.dart';
import 'package:flutter_application_2/Widgets/custom_text_field.dart';
import 'package:flutter_application_2/Widgets/custom_button.dart';
import 'package:flutter_application_2/services/storage_service.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isLoading = false;
  List<String> registeredEmails = [];

  @override
  void initState() {
    super.initState();
    _loadEmails();
  }

  Future<void> _loadEmails() async {
    registeredEmails = await StorageService.loadEmails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Wavy.jpg',
                    height: 200,
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32),
                  CustomTextField(
                    hintText: 'Email *',
                    inputType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Password *',
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 32),
                  CustomButton(
                    text: isLoading ? 'Logging In...' : 'Login',
                    onTap: () async {
                      final emailRegex = RegExp(r'^\S+@\S+\.\S+ ?$');
                      if (email == null || email!.isEmpty || password == null || password!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email and password are required.')),
                        );
                        return;
                      }
                      if (!emailRegex.hasMatch(email!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a valid email address.')),
                        );
                        return;
                      }
                      if (password!.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password must be at least 6 characters.')),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        isLoading = false;
                      });
                      if (registeredEmails.contains(email)) {
                        Navigator.pushReplacementNamed(context, 'HomePage');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email not registered. Please sign up first.')),
                        );
                        Navigator.pushReplacementNamed(context, 'SignUpPage', arguments: email);
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'SignUpPage');
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 244, 113, 73),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 