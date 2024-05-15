import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/route_names.dart';
import 'package:taxi_app/screens/authentication_screen.dart';

class MySlashScreen extends StatefulWidget {
  const MySlashScreen({super.key});

  @override
  State<MySlashScreen> createState() => _MySlashScreenState();
}

class _MySlashScreenState extends State<MySlashScreen> {
  Future<void> printAllSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    print(allKeys.length);

    for (final key in allKeys) {
      final value = prefs.get(key);
      print('Key: $key, Value: $value');
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).setFirstLunch(false);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        if (loggedIn) {
          print('LOGGD IN ');
        } else {
          print('LOGGD OUT ');
        }

        final route = loggedIn ? RouteNames.main : RouteNames.authetication;
        context.go(route);
      },
    );
    //printAllSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: Placeholder(),
            ),
            Text("Logo"),
          ],
        ),
      ),
    );
  }
}
