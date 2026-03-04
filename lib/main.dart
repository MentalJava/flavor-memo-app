import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/core/di/di_setup.dart';
import 'package:flavor_memo_app/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.prod;
  setupDI();

  runApp(const MyApp());
}
