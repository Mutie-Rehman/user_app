import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool _isMapInitialized = false; // ✅ Prevent reinitialization

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  /// Request location permission
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, initialize map
      _initializeMap();
    } else if (status.isDenied) {
      // If permission is denied, open app settings
      await openAppSettings();
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, prompt user to open settings
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Location permission is permanently denied. Please enable it from settings.',
          ),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    }
  }

  /// Initialize Google Map
  void _initializeMap() async {
    if (_isMapInitialized) return; // ✅ Prevent multiple initialization

    final GoogleMapController controller = await _controllerGoogleMap.future;
    newGoogleMapController = controller;

    // ✅ No need to use setState() — controller assignment is enough
    _isMapInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          if (!_controllerGoogleMap.isCompleted) {
            _controllerGoogleMap.complete(controller);
          }
        },
        myLocationEnabled: true, // ✅ Show current location
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        compassEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
