import 'package:flutter/material.dart';
// import 'ksp_datathon/lib/features/user_auth/presentation/pages/login_page.dart';
class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key,this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget.child!), (route) => false);
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to CompStats",
          style: TextStyle(
            color: Colors.blue, 
            fontWeight: FontWeight.bold,
            ),
        ),
      ),
    );
  }
}
