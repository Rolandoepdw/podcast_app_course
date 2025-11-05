import 'package:flutter/material.dart';
import 'package:podcast_app_course/presentation/style/app_dimensions.dart';
import 'package:podcast_app_course/presentation/widgets/podcast_item.dart';

class PodcastsPage extends StatefulWidget {
  const PodcastsPage({super.key});

  @override
  State<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends State<PodcastsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Podcasts'), centerTitle: true),
      body: ListView.separated(
        itemCount: 1,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppDimensions.paddingS),
        itemBuilder: (context, index) => const PodcastItem(),
      ),
    );
  }
}
