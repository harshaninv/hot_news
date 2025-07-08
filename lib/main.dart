import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_news/controllers/news_controller.dart';
import 'package:hot_news/screens/onboarding.dart';
import 'package:hot_news/services/api_client.dart';
import 'package:hot_news/services/news_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsController(NewsService(ApiClient())),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hot News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ).copyWith(primary: Color.fromARGB(255, 255, 123, 0)),
      ),
      home: const OnboardingScreen(),
    );
  }
}
