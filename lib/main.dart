import 'package:flutter/material.dart';
import 'package:podcast_app_course/presentation/pages/podcasts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PodcastsPage(),
    );
  }
}