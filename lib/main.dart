import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MaterialApp(
    home: MyPageHome(),
  ));
}

class MyPageHome extends StatefulWidget {
  @override
  _MyPageHomeState createState() => _MyPageHomeState();
}

class _MyPageHomeState extends State<MyPageHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print('User Name: ${user.displayName}');
    return user;
  }

  void _signOut(){
    googleSignIn.signOut();
    print('User sign out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Firestore'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () => _signIn()
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e)),
            child: Text('Sign in'),
            color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          RaisedButton(
            onPressed: _signOut,
            child: Text('Sign out'),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
