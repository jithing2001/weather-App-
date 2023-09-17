import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weter_app/view/base_Screen.dart';

class LocationService {
  Future<void> goToHome(context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 30,
          width: 60,
          child: Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.black, size: 50),
          ),
        ),
      ),
    );
    Center(
      child: LoadingAnimationWidget.waveDots(color: Colors.white, size: 50),
    );
    await Future.delayed(const Duration(seconds: 1));
    final postion = await getCurrentLocation();
    final lat = postion.latitude;
    final long = postion.latitude;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BaseScreen(latitude: lat, longitude: long),
        ),
        (route) => false);
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are dined');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permently denied, We cannot request');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }
}
