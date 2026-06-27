import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

// step 3 : Check internet connection
import 'package:connectivity_plus/connectivity_plus.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();

    //Step 3
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (!mounted) return;

    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      _showToast(context, 'Mobile network available');
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      _showToast(context, 'WIFI is available');
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      _showToast(context, 'Ethernet connection available');
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      _showToast(context, 'Vpn connection active.');
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      _showToast(context, 'Bluetooth active.');
    } else if (connectivityResult.contains(ConnectivityResult.satellite)) {
      // Carrier-provided satellite network available
      _showToast(context, 'Carrier-provided active.');
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      _showToast(context, 'Other is available.');
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      if (!mounted) return;
      setState(() {
        _showAlertDialog(
          context,
          'No Internet',
          'Please check your internet connection',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'android/assets/image/app_screen.png',
                width: 220,
                height: 220,
              ),
              const SizedBox(height: 20),
              const SpinKitSpinningLines(color: Colors.pinkAccent),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: const Center(
        child: Text(
          'This is a Second Screen',
          style: TextStyle(
            fontSize: 24,
            color: Colors.amber,
            fontWeight: FontWeight.w500,
            fontFamily: 'Alike',
          ),
        ),
      ),
    );
  }
}

// step 4 : show toast message
void _timer(BuildContext context) {
  // เมื่อครบ 3 วิ ให้ไปหน้า Second Screen
  Timer(
    const Duration(seconds: 3),
    () {
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SecondScreen()),
      );
    },
  );
}

void _showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Colors.amberAccent,
      behavior: SnackBarBehavior.floating,
    ),
  );
  _timer(context);
}

void _showAlertDialog(BuildContext context, String title, String msg){
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, 
        style: TextStyle(
          fontSize: 24,
          color: Colors.amber,
          fontWeight: FontWeight.w500,
          fontFamily: "Alike"
          ),
        ),
        content: Text(msg),
        actions: <Widget>[
          ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amberAccent),
          ),
            onPressed:(){
              Navigator.pop(context);
            },
            child: Text("OK",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Alike",
            ),
            ),
          ),
        ],
      );
  });
}