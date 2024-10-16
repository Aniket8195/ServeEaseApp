import 'package:flutter/material.dart';
import 'package:serve_ease/Routes/app_router.dart';
import 'package:serve_ease/Theme/theme_data.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serve Ease',
      theme: ThemeClass.themeData,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
    );
  }
}
