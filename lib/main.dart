import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'router/app_router.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    ProviderScope(
      child: Foodie(),
    ),
  );
}

// ignore: must_be_immutable
class Foodie extends StatelessWidget {
  Foodie({super.key});

  AppRouter? router;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        router ??= AppRouter(ref);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Foodie Recipe App',
          theme: AppThemes.primary(),
          routerDelegate: router!.router.routerDelegate,
          routeInformationParser: router!.router.routeInformationParser,
        );
      },
    );
  }
}
