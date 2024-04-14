import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ksp_datathon/features/user_auth/presentation/widgets/pie_chart_sample_2.dart';
import 'package:ksp_datathon/features/user_auth/presentation/widgets/web_view_container.dart';

import '../../../../global/common/toast.dart';
import 'package:ksp_datathon/features/user_auth/presentation/widgets/bar_chart_sample_3.dart'; // Ensure this import is correct

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Add the method here, inside the state class
  Future<String?> _getUserPosition() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Get a reference to the user's data in the Realtime Database
    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/${currentUser.uid}');
    
    // Read the user's position from the database
    DataSnapshot snapshot = await userRef.child('position').get();
    if (snapshot.exists) {
      return snapshot.value as String?;
    } else {
      return null; // The user does not have a position set
    }
  }
  return null; // No current user logged in
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("HomePage"),
      ),
      body: 
        const WebViewContainer(),
      
    );
  }
}
