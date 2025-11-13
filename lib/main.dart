import 'package:agro_app/utils/getx_pages.dart';
import 'package:agro_app/views/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi bahasa Indonesia untuk format tanggal
  await initializeDateFormatting('id_ID', null);

  await Supabase.initialize(
    url: 'https://gsjxslwjzxzpcpqnaeny.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdzanhzbHdqenh6cGNwcW5hZW55Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc3MDU2MzksImV4cCI6MjA2MzI4MTYzOX0.py1bh5bt_84ErV930zkkjLAguPJMtoCPQUaGYAD64Ts',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Agro App',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      getPages: GetxPages.pages,
      home: const Splashscreen(),
    );
  }
}
