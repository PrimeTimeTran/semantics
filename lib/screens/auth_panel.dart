import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:semantic/utils/firebase.dart';

class AuthPanel extends StatefulWidget {
  const AuthPanel({super.key});

  @override
  State<AuthPanel> createState() => _AuthPanelState();
}

class _AuthPanelState extends State<AuthPanel> {
  late String email = '';
  late String password = '';
  @override
  void initState() {
    super.initState();
    FB.pageView('Sign in');
    FB.logSignIn();
  }

  Future<void> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  createAccount() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamed(context, '/');
      FB.logSignUp();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamed(context, '/');
      FB.logSignIn();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(200, 10, 200, 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              child: Text('Welcome'),
              alignment: Alignment.centerLeft,
            ),
            TextField(
              onChanged: (String value) async {
                setState(() {
                  email = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                hintText: 'john@email.com',
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              onChanged: (String value) async {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                hintText: '********',
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: MaterialButton(
                color: Colors.lightBlue,
                height: 50,
                minWidth: 700,
                child: const Text('Sign In'),
                onPressed: () {
                  signIn();
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: MaterialButton(
                color: Colors.lightBlue,
                height: 50,
                minWidth: 700,
                child: const Text('Create Account'),
                onPressed: () {
                  createAccount();
                },
              ),
            ),
            MaterialButton(
              child: const Text('Google'),
              onPressed: () {
                signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
