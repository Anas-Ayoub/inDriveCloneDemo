import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/widgets/phone_text_field%20copy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePicture(
                  name: user!.displayName ?? 'NO NAM',
                  radius: 40,
                  fontsize: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user!.displayName ?? 'NO NAM',
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text('(4.7)')
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'First Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Last Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Phone Number',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Email',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
