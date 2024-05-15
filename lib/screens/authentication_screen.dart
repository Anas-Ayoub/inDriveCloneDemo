import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/route_names.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/widgets/phone_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackBarType { success, failure, info }

final _formKey = GlobalKey<FormState>();

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _phoneController;
  late ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context: context);
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Join us via phone number",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "We'll text a code to verify your number",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  color: const Color.fromARGB(144, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              PhoneTextField(
                controller: _phoneController,
                validator: (txt) {
                  if (txt!.length < 9) {
                    return 'Must conatin 9 digits';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              PrimaryButton(
                text: "Next",
                textColor: Colors.black,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final loadingProvider =
                        Provider.of<LoadingProvider>(context, listen: false);

                    String phoneNumber = "+212${_phoneController.text.trim()}";
                    print(phoneNumber);

                    loadingProvider.show(
                      context,
                      msg: "Signing in with Phone Number...",
                    );

                    await AuthService().signInWithPhone(context, phoneNumber);
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Or login with",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: 12,
                  color: const Color.fromARGB(144, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                text: "Continue With Google",
                color: Color.fromARGB(255, 63, 63, 63),
                icon: Image.asset(
                  "assets/google.png",
                ),
                isBold: true,
                onPressed: () async {
                  final loadingProvider =
                      Provider.of<LoadingProvider>(context, listen: false);
                  loadingProvider.show(
                    context,
                    msg: "Signing in with Google...",
                  );

                  User? user = await AuthService().signInWithGoogle();
                  if (user != null) {
                    showTopSnackBar(
                      dismissType: DismissType.onSwipe,
                      dismissDirection: [
                        DismissDirection.up,
                        DismissDirection.horizontal
                      ],
                      Overlay.of(context),
                      displayDuration: const Duration(milliseconds: 3000),
                      reverseAnimationDuration:
                          const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 500),
                      const CustomSnackBar.success(
                        backgroundColor: Color.fromARGB(255, 37, 145, 40),
                        message:
                            "Good job, your release is successful. Have a nice day",
                      ),
                    );
                    loadingProvider.hide();
                    await Future.delayed(const Duration(milliseconds: 1200));
                    context.goNamed(RouteNames.main);
                  } else {
                    showTopSnackBar(
                      dismissType: DismissType.onSwipe,
                      dismissDirection: [
                        DismissDirection.up,
                        DismissDirection.horizontal
                      ],
                      Overlay.of(context),
                      displayDuration: const Duration(milliseconds: 3000),
                      reverseAnimationDuration:
                          const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 500),
                      const CustomSnackBar.error(
                        message: "Authetication not procceded",
                      ),
                    );
                    loadingProvider.hide();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.aBeeZee(
                    fontSize: 12,
                    color: const Color.fromARGB(144, 255, 255, 255),
                  ),
                  children: [
                    const TextSpan(
                        text: "Joining our app means you agree with our "),
                    TextSpan(
                      text: "Terms of Use",
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () => {},
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () => {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
