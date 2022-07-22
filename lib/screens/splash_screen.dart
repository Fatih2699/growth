// import 'package:flutter/material.dart';
// import 'package:growth/screens/login_screen.dart';
// import 'package:growth/screens/registers/registers_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     Future.delayed(Duration(seconds: 3), () async {
//       SharedPreferences _prefs = await SharedPreferences.getInstance();
//       var token = _prefs.getString('token');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               token == null ? LoginScreen() : RegistersScreen(),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(
//                 'assets/images/splashscreen.jpg',
//               ),
//               fit: BoxFit.cover),
//         ),
//       ),
//     );
//   }
// }
