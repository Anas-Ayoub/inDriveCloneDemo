import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/theme/strings.dart';

class FilledRoundedPinPut extends StatefulWidget {
  final String verificationId;
  const FilledRoundedPinPut({Key? key, required this.verificationId})
      : super(key: key);

  @override
  FilledRoundedPinPutState createState() => FilledRoundedPinPutState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class FilledRoundedPinPutState extends State<FilledRoundedPinPut> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  //bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = primaryColor;
    const errorColor = Color.fromRGBO(131, 13, 5, 1);
    const fillColor = textFieldBackColor;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) async {
          print(pin);
          await AuthService().submitOTP(
              context: context,
              otp: pin,
              verificationId: widget.verificationId);
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
