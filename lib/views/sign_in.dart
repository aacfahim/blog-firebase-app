import 'package:blog_app/helper/firebase_helpers.dart';
import 'package:blog_app/views/sign_up.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(label: Text("Email")),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(label: Text("Password")),
          ),
          ElevatedButton(
              onPressed: () {
                var email = emailController.text;
                var password = passwordController.text;

                FirebaseHelpers()
                    .signInUsingEmailPassword(email, password, context);
              },
              child: Text("SIGN IN")),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text("Not registered yet? Sign Up"))
        ]),
      ),
    );
  }
}
