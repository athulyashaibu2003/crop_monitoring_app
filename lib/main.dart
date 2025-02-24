import 'package:crop_monitoring_app_orginal/Views/bottom_navigation_bar_screen/bottom_nav_bar.dart';
import 'package:crop_monitoring_app_orginal/Views/splash_screen/splash_screen.dart';
import 'package:crop_monitoring_app_orginal/auth/login_or_register.dart';
import 'package:crop_monitoring_app_orginal/controller/ndvi_image_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ml', 'IN'),
        Locale('kn', 'IN'),
      ],
      path: 'assets/translations',
      // fallbackLocale: const Locale('en', 'US'),
      // startLocale: const Locale('en', 'US'),
      // saveLocale: false,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NdviImageController(),)
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
