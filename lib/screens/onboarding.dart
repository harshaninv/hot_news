import 'package:flutter/material.dart';
import 'package:hot_news/screens/home.dart';
import 'package:hot_news/widgets/onboard_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: double.infinity,
            height: 500,
            child: const OnboardImage(),
          ),
          // title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('News from around the world for you', style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
            ),
          ),
          // headline
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8),
            child: Text('Best time to read, take your time to read a little more of this world', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            ),
          ),
          FilledButton( 
            onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen())), 
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              minimumSize: Size(300, 50)
            ),
            child: const Text('Get Started', style: TextStyle(
              fontSize: 20
            ),),
          ),
          const SizedBox(height: 8,)
        ],
      ),
    );
  }
}