import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';
import 'package:podcast_app_course/services/api/podcast_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;

  const PodcastItem({super.key, required this.podcast});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  final podcastApi = PodcastApi();
  double progress = 0.0;
  String? savedPath;

  Future<String?> getSavedPath() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    return savedPath = sharedPreferences.getString('path');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.podcast.title),
      trailing: Stack(
        children: [
          Positioned.fill(
            child: CircularProgressIndicator.adaptive(value: progress),
          ),
          IconButton(
            icon: savedPath == null
                ? const Icon(Icons.download)
                : const Icon(Icons.play_arrow),
            onPressed: () async {
              final path = '${widget.podcast.title}/${widget.podcast.id}.mp3';
              await podcastApi.downloadPodcast(
                widget.podcast.audio,
                path,
                onReceiveProgress: (count, total) {
                  setState(() => progress = count / total);
                },
              );
              await getSavedPath();
              setState(() => progress = 0.0);
            },
          ),
        ],
      ),
      leading: CachedNetworkImage(
        imageUrl: widget.podcast.image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            ColoredBox(color: Theme.of(context).primaryColor),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
