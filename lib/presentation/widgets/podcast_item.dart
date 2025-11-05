import 'package:flutter/material.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';
import 'package:podcast_app_course/services/api/podcast_api.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;

  const PodcastItem({super.key, required this.podcast});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  final podcastApi = PodcastApi();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.podcast.title),
      trailing: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () async {
          print(widget.podcast.audio);
          final path = '${widget.podcast.title}/${widget.podcast.id}.mp3';
          await podcastApi.downloadPodcast(
            widget.podcast.audio,
            path,
            onReceiveProgress: (count, total) {
              debugPrint('count: $count, total: $total');
            },
          );
        },
      ),
      leading: Image.network(
        widget.podcast.image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
