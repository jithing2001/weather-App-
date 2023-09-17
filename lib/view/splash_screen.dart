import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weter_app/model/constands.dart';
import 'package:weter_app/services/location_services.dart';
import 'package:weter_app/view/loginscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1));
      final userLogin = FirebaseAuth.instance.currentUser;
      if (userLogin == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
       await LocationService().goToHome(context);
      }
    });
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(ksplasimae))),
            child: const Center(
                child: CircularProgressIndicator(color: kwhiteColor))));
  }
}
