import 'package:flutter/material.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;

  const PodcastItem({super.key, required this.podcast});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.podcast.title),
      trailing: IconButton(icon: const Icon(Icons.download), onPressed: () {}),
      leading: Image.network(
        widget.podcast.image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
