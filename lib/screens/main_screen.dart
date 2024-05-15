import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/screens/home_screen.dart';
import 'package:taxi_app/route_names.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTabBarIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(user!.displayName ?? 'NO NAM'),
                Text(user.email ?? 'NO MAIL'),
                Text(user.phoneNumber ?? 'NO PHON'),
                Card(),
                TextButton(
                  onPressed: () {
                    context.pushNamed(RouteNames.profile);
                  },
                  child: Row(
                    children: [
                      ProfilePicture(
                          name: user!.displayName ?? 'NO NAM',
                          radius: 20,
                          fontsize: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(user!.displayName ?? 'NO NAM')
                    ],
                  ),
                ),
                const Spacer(),
                TextButton(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.exit_to_app_rounded,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log Out',
                        style: GoogleFonts.aBeeZee(fontSize: 20),
                      )
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
      body: HomeScreen(),
    );
  }
}

































// import 'package:flutter/material.dart';
// import 'package:taxi_app/dummy_data.dart';
// import 'package:taxi_app/mainScreens/bottom_sheet.dart';
// import 'package:taxi_app/scrn1%20copy%202.dart';
// import 'package:taxi_app/scrn1%20copy%203.dart';
// import 'package:taxi_app/scrn1%20copy.dart';
// import 'package:taxi_app/scrn1.dart';
// import 'package:taxi_app/theme/colors.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int currentTabBarIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: _tabController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           MyWidget1(),
//           MyWidget2(),
//           MyWidget3(),
//           MyWidget4(),
//         ],
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(splashColor: Colors.transparent),
//         child: BottomNavigationBar(
//           currentIndex: currentTabBarIndex,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//           ],
//           backgroundColor: Colors.black,
//           unselectedItemColor: Colors.white,
//           selectedItemColor: primary,
//           showUnselectedLabels: false,
//           type: BottomNavigationBarType.fixed,
//           onTap: (value) {
//             onTabBarClicked(value);
//           },
//         ),
//       ),
//     );
//   }

//   void onTabBarClicked(int index) {
//     setState(() {
//       currentTabBarIndex = index;
//       _tabController.index = currentTabBarIndex;
//     });
//   }
// }
