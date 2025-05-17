import 'package:flutter/material.dart';
import 'package:flutter_application_2/Widgets/custom_text_field.dart';
import 'package:flutter_application_2/Widgets/custom_button.dart';
import 'package:flutter_application_2/screens/login_page.dart';
import 'package:flutter_application_2/services/storage_service.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'SignUpPage';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;
  String? password;
  String? confirmPassword;
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

  Future<void> _registerEmail() async {
    if (!registeredEmails.contains(email)) {
      registeredEmails.add(email!);
      await StorageService.saveEmails(registeredEmails);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is String && (email == null || email!.isEmpty)) {
      email = arg;
    }
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
                    'assets/images/signup_image.jpg',
                    height: 200,
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
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
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Confirm Password *',
                    obscureText: true,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                  ),
                  SizedBox(height: 32),
                  CustomButton(
                    text: isLoading ? 'Signing Up...' : 'Sign Up',
                    onTap: () async {
                      final emailRegex = RegExp(r'^\S+@\S+\.\S+ ?$');
                      if (email == null || email!.isEmpty || password == null || password!.isEmpty || confirmPassword == null || confirmPassword!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('All fields are required.')),
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
                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords do not match.')),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(Duration(seconds: 1));
                      if (registeredEmails.contains(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('This email is already registered.')),
                        );
                        setState(() { isLoading = false; });
                        return;
                      }
                      await _registerEmail();
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacementNamed(context, 'HomePage');
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'LoginPage');
                        },
                        child: Text(
                          'Sign in',
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