import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/widgets/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset("assets/otpImage1.png"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Verification",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Enter the code sent to the number",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 17,
                      color: Color.fromARGB(171, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "+212123456789",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 17,
                      color: Color.fromARGB(171, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FilledRoundedPinPut(verificationId: widget.verificationId),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Didn't recieve code ?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                      color: const Color.fromARGB(144, 255, 255, 255),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Resend"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
