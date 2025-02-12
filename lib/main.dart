import 'package:flutter/material.dart';
import 'package:trendfashion/features/Product/presintation/page/productsPage.dart';
import 'injection_container.dart' as object;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكد من التهيئة هنا
  await object.init();
  runApp(const MyApp());
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
        useMaterial3: true,
      ),
      home: ProductPage(),
    );
  }
}
