import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:weter_app/services/authentication_service.dart';
import 'package:weter_app/services/location_services.dart';
import 'package:weter_app/view/base_Screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('lib/assets/animation_lkpup8cs.json', height: 400),
          ElevatedButton(
              onPressed: () async {
                UserCredential cred = await Authentication().signInWithGoogle();

                if (cred != null) {
                  await LocationService().goToHome(context);
                } else {
                  log('error');
                }
              },
              child: const Text('Sign in with Google')),
        ],
      )),
    );
  }
}
