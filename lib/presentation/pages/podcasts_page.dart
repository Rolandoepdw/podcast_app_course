import 'package:flutter/material.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';
import 'package:podcast_app_course/presentation/style/app_dimensions.dart';
import 'package:podcast_app_course/presentation/widgets/podcast_item.dart';
import 'package:podcast_app_course/services/api/podcast_api.dart';

class PodcastsPage extends StatefulWidget {
  const PodcastsPage({super.key});

  @override
  State<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends State<PodcastsPage> {
  List<Podcast>? podcasts;
  final podcastApi = PodcastApi();

  Future<void> fetchPodcasts() async {
    podcasts = await podcastApi.fetchPodcasts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Podcasts'), centerTitle: true),
      body: podcasts == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: podcasts!.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppDimensions.paddingS),
              itemBuilder: (context, index) {
                final podcast = podcasts![index];
                return PodcastItem(podcast: podcast);
              } ,
            ),
    );
  }
}
