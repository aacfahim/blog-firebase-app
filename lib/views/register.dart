import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController age = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return  users.add({
      'name': name.text,
      'email': email.text,
      'phone': phone.text,
      'address': address.text,
      'age': age.text

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        TextField(
          controller: name,
          decoration: InputDecoration(label: Text("Name")),
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(label: Text("Email")),
        ),
        TextField(
          controller: address,
          decoration: InputDecoration(label: Text("Address")),
        ),
        TextField(
          controller: phone,
          decoration: InputDecoration(label: Text("Phone")),
        ),
        TextField(
          controller: age,
          decoration: InputDecoration(label: Text("Age")),
        ),

        ElevatedButton(onPressed: ()=>addUser(), child: Text("SUBMIT"))
      ],),
    )

    );
  }
}
