import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ksp_datathon/features/app/splash_screen/splash_screen.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/assign_task.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/home.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/login_page.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/phone_home.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/profile_page.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/scheduled_task_page.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:ksp_datathon/features/user_auth/presentation/pages/update_task_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        databaseURL: 'https://ksp-datathon-default-rtdb.firebaseio.com/',
        apiKey: "AIzaSyC_8UGa4Emq4IeSTEWoeDIRzE_GcB24sFg",
        appId: "1:8441516221:web:aea526db314b75396027d4",
        messagingSenderId: "8441516221",
        projectId: "ksp-datathon",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => const SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/homePhone':(context) => const PhoneHomePage(),
      },
    );
  }
}