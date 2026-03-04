import 'package:expense_tracker/pages/dashboard.dart';
import 'package:expense_tracker/pages/setup_page.dart';
import 'package:expense_tracker/theme/deep_finance.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("user_name");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkFirstTime(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == true) {
            return const Dashboard();
          } else {
            return const SetupPage();
          }
        },
      ),
    );
  }
}
