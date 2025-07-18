import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_supabase/Storage/Image_services.dart';
import 'package:flutter_supabase/Storage/storage_View.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Must come before any async setup

  await dotenv.load(); // Load .env BEFORE using it

  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_KEY']!,
    );
    print('Hiiiiiiiiiii');
  } catch (e) {
    print('Error initializing Supabase: $e');
  }
  Get.put(ImageServices());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StorageView(),
    );
  }
}
