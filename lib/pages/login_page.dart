import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/widgets/my_button.dart';
import 'package:flutter_auth/widgets/my_textfield.dart';
import 'package:flutter_auth/widgets/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                message,
              ),
            ),
          );
        },
      );
    }

    // try signin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showErrorMessage(e.code);
      } else if (e.code == 'Wrong-password') {
        showErrorMessage(e.code);
      }
    }
  }

  // pop the loading circle
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  //logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'welcome back you\'ve been missed',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),

                  const SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  MyButton(
                    onTap: signUserIn,
                    buttonName: 'Sign in',
                  ),
                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 0.5,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'assets/images/Google_logo.png')
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
