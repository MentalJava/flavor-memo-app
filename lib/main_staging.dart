import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/core/di/di_setup.dart';
import 'package:flavor_memo_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flavor_memo_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlavorConfig.appFlavor = Flavor.staging;
  setupDI();

  runApp(const MyApp());
}
