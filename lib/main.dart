import 'package:flutter/material.dart';
import 'package:trendfashion/core/AppTheme.dart';
import 'package:trendfashion/core/util/app_router.dart';
import 'injection_container.dart' as object;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await object.init();
    runApp(const MyApp());
  } catch (e) {
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'TrendFashion',
      initialRoute: AppRouter.initial,
      routes: AppRouter.routes,
      
    );
    
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error_outline, size: 50, color: Colors.red),
              SizedBox(height: 20),
              Text('Failed to initialize app'),
            ],
          ),
        ),
      ),
    );
  }
}
