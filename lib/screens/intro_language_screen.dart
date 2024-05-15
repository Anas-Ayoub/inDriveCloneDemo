import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroLanguage extends StatefulWidget {
  const IntroLanguage({super.key});

  @override
  State<IntroLanguage> createState() => _IntroLanguageState();
}

String lang = "English";

class _IntroLanguageState extends State<IntroLanguage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      // appBar: AppBar(title: Text('Language Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select a language:',
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                height: 200,
                child: Placeholder(),
              ),
              SizedBox(
                height: 30,
              ),
              RadioListTile(
                  title: Text(
                    'English',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                  value: 'English',
                  groupValue: lang,
                  onChanged: (value) {
                    setState(() {
                      lang = value!;
                    });
                  }),
              RadioListTile(
                  title: Text(
                    'French',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                  value: 'French',
                  groupValue: lang,
                  onChanged: (value) {
                    setState(() {
                      lang = value!;
                    });
                  }),
              RadioListTile(
                title: Text(
                  'Arabic',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                  ),
                ),
                value: 'Arabic',
                groupValue: lang,
                onChanged: (value) {
                  setState(() {
                    lang = value!;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              PrimaryButton(
                  text: "Next",
                  onPressed: () {
                    languageProvider.setSelectedLanguage(lang);
                    context.go("/authetication");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
