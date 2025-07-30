import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/routing/router.gr.dart';
import 'package:flutter/material.dart';


@RoutePage()
class UISplashScreen extends StatefulWidget {
  const UISplashScreen({Key? key}) : super(key: key);

  @override
  State<UISplashScreen> createState() => _UISplashScreenState();
}

class _UISplashScreenState extends State<UISplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Here you can add any initialization logic
    // For example, check if user is already logged in
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    
    // For now, always redirect to login
    if (mounted) {
      context.router.replace(const LoginScreenRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}