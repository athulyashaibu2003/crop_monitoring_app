import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr(   )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded, color: Colors.blueGrey),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CHOOSE LANGUAGE",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                LocalizationChecker.changeLanguge(
                  context: context,
                  locale: const Locale('en', 'US'),
                );
              },
              child:
                  const Text(
                    "English",
                    style: TextStyle(color: Colors.blueAccent),
                  ).tr(),
            ),
            TextButton(
              onPressed: () {
                LocalizationChecker.changeLanguge(
                  context: context,
                  locale: const Locale('kn', 'IN'),
                );
              },
              child:
                  const Text(
                    "ಕನ್ನಡ",
                    style: TextStyle(color: Colors.blueAccent),
                  ).tr(),
            ),
            TextButton(
              onPressed: () {
                LocalizationChecker.changeLanguge(
                  context: context,
                  locale: const Locale('ml', 'IN'),
                );
              },
              child:
                  const Text(
                    "മലയാളം",
                    style: TextStyle(color: Colors.blueAccent),
                  ).tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class LocalizationChecker {
  static changeLanguge({
    required BuildContext context,
    required Locale locale,
  }) {
    EasyLocalization.of(context)!.setLocale(locale);

    // Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    // if (currentLocal == const Locale('en', 'US')) {
    //   EasyLocalization.of(context)!.setLocale(const Locale('ml', 'IN'));
    // } else {
    //   EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
    // }
  }
}
