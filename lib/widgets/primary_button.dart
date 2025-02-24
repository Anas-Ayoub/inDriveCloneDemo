import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/theme/strings.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color? textColor;
  final double width;
  final double height;
  final bool? isBold;
  final Widget? icon;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.width = double.infinity,
    this.height = 55,
    this.isBold = false,
    this.icon,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          padding: EdgeInsets.zero,
          textStyle: GoogleFonts.aBeeZee(
              fontSize: 20,
              fontWeight: isBold! ? FontWeight.bold : FontWeight.normal),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.all(15),
                child: icon!,
              ),
            if (icon != null) const SizedBox(width: 5),
            Text(text),
          ],
        ),
      ),
    );
  }
}
