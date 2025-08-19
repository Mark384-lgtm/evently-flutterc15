import 'package:evently_c15_flutter/UI/Authentication/Login/Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser == null) {

        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routName,
              (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("\nuser ${FirebaseAuth.instance.currentUser?.uid.toString()}");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.routName,
                (route) => false,
              );
            },
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
