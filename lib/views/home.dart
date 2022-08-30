import 'package:blog_app/helper/firebase_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String inputData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return user.email.toString();
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Posts"),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 5),
            child: Text(
              "Logged in as\n${inputData()}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () => FirebaseHelpers().signOut(context),
                child: Icon(Icons.logout)),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                elevation: 10,
                child: Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      image: NetworkImage(data['image']),
                      fit: BoxFit.fill,
                    ),
                    ListTile(
                      title: Text(data['title']),
                      subtitle: Text('${data['desc']}', maxLines: 3),
                    ),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  flex: 1,
                                  child: AlertDialog(
                                      scrollable: true,
                                      content: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Image.network(data['image'],
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                  width: 500),
                                              ListTile(
                                                title: Text(data['title']),
                                                subtitle:
                                                    Text('${data['desc']}'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              });
                        },
                        child: Text("See More"))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
