import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/route_names.dart';
import 'package:taxi_app/screens/authentication_screen.dart';
import 'package:taxi_app/screens/intro_language_screen.dart';
import 'package:taxi_app/screens/main_screen.dart';
import 'package:taxi_app/screens/profile_screen.dart';
import 'package:taxi_app/splashScreen/splash_screen.dart';
import 'package:taxi_app/screens/otp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.userChanges().listen((User? user) {
    print('in ===> userChanges().listen');
    _router.refresh();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Taxi Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color.fromARGB(255, 28, 31, 36)),
      debugShowCheckedModeBanner: false,
    );
  }
}

//ROUTES
final GoRouter _router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) async {
    final isFL = Provider.of<AppProvider>(context, listen: false).isFirstLunch;
    print('isFirstLunch = $isFL');
    print('in rdirct');
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    loggedIn ? print('LOOOOOGGGGGG') : print('NOT LOOOOG');
    print("Path = ${state.path}");
    print("Path = ${state.fullPath}");
    print("Path = ${state.matchedLocation}");
    print("Path = ${state.uri}");

    if (state.fullPath == "${RouteNames.otp}/:verificationId") {
      return null;
    }
    if (isFL) {
      return RouteNames.splash;
    }
    if (!loggedIn) {
      return RouteNames.authetication;
    }
    return null;
  },
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const MySlashScreen();
      },
    ),
    GoRoute(
      name: RouteNames.main,
      path: RouteNames.main,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      name: RouteNames.profile,
      path: RouteNames.profile,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: RouteNames.introLanguage,
      name: RouteNames.introLanguage,
      builder: (BuildContext context, GoRouterState state) {
        return const IntroLanguage();
      },
    ),
    GoRoute(
      path: RouteNames.authetication,
      name: RouteNames.authetication,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: "${RouteNames.otp}/:verificationId",
      name: RouteNames.otp,
      builder: (BuildContext context, GoRouterState state) {
        final verificationId = state.pathParameters['verificationId'];
        // Handle potential null verificationId
        return OtpScreen(verificationId: verificationId!);
      },
    ),
  ],
);





















// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   prefs = await SharedPreferences.getInstance();
//   prefs.clear();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   FirebaseAuth.instance.userChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });

//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (context) => LanguageProvider()),
//     ],
//     child: MyApp(
//       child: MaterialApp.router(
//         routerConfig: _router,
//         title: 'Taxi Demo',
//         theme: ThemeData(
//             brightness: Brightness.dark,
//             scaffoldBackgroundColor: Color.fromARGB(255, 28, 31, 36)),
//         debugShowCheckedModeBanner: false,
//       ),
//     ),
//   ));
// }

// class MyApp extends StatefulWidget {
//   final Widget? child;
//   MyApp({super.key, this.child});

//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_MyAppState>()!.restartApp();
//   }

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Key key = UniqueKey();

//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(key: key, child: widget.child!);
//   }
// }