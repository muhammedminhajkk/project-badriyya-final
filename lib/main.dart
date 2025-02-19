import 'package:flutter/material.dart';
import 'package:project_badriyya/core/navigation/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
