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
      // const SingleChildScrollView( // This enables the scrolling on the page
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const SizedBox( // Adjust the height and width as needed
        //       height: 300, // Set a specific height for the bar chart widget
        //       width: double.infinity, // Full width of the screen
        //       child: BarChartSample3(),
        //     ),
        //     const SizedBox(height: 20),
        //     const WebViewContainer(),
        //     const SizedBox(height: 30),
        //     FutureBuilder<String?>(
        //       future: _getUserPosition(), // Call the method inside FutureBuilder
        //       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return const CircularProgressIndicator();
        //         } else if (snapshot.hasError) {
        //           return Text('Error: ${snapshot.error}');
        //         } else {
        //           // Check if the user position is 'Position3'
        //           if (snapshot.data == "Position3") {
        //             // Return the widgets you want to show for this position
        //             return  const Column(
        //               children: [
        //                  PieChartSample2()
        //               ],
        //             );
        //           } else {
        //             // Return an empty Container or any other widget for users with other positions
        //             return Container();
        //           }
        //         }
        //       },
        //     ),
        //     const SizedBox(height: 20),
        //     const SizedBox(height: 20),
        //     FutureBuilder<String?>(
        //       future: _getUserPosition(), // Call the method inside FutureBuilder
        //       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return const CircularProgressIndicator();
        //         } else if (snapshot.hasError) {
        //           return Text('Error: ${snapshot.error}');
        //         } else {
        //           // Check if the user position is 'Position3'
        //           if (snapshot.data == "Position3") {
        //             // Return the widgets you want to show for this position
        //             return  const Column(
        //               children: [
        //                  PieChartSample2()
        //               ],
        //             );
        //           } else {
        //             // Return an empty Container or any other widget for users with other positions
        //             return Container();
        //           }
        //         }
        //       },
        //     ),
        //     const SizedBox(height : 20,),
        //     GestureDetector(
        //       onTap: () async {
        //         await FirebaseAuth.instance.signOut();
        //         Navigator.pushNamed(context, "/login");
        //         showToast(message: "Successfully signed out");
        //       },
        //       child: Container(
        //         height: 45,
        //         width: 100,
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: const Center(
        //           child: Text(
        //             "Sign out",
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     // Add other widgets if necessary
        //   ],
        // ),
        const WebViewContainer(),
      
    );
  }
}
