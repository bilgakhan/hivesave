import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivegenapp/core/router/router.dart';
import 'package:hivegenapp/db/db_service.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  UserDbService.registerAdapter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerate.router.onGenerate,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
