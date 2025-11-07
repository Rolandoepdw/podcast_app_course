import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';
import 'package:podcast_app_course/services/download/download_service.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;

  const PodcastItem({super.key, required this.podcast});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  final downloadService = DownloadService();
  double progress = 0.0;
  bool isDownloaded = false;

  @override
  void initState() {
    super.initState();
    _checkIfDownloaded();
  }

  void _checkIfDownloaded() async {
    final downloaded = await downloadService.isPodcastDownloaded(
      widget.podcast,
    );
    setState(() {
      isDownloaded = downloaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.podcast.title),
      trailing: Stack(
        alignment: Alignment.center,
        children: [
          if (progress > 0 && progress < 1)
            CircularProgressIndicator.adaptive(value: progress),
          IconButton(
            icon: isDownloaded
                ? const Icon(Icons.play_arrow)
                : const Icon(Icons.download),
            onPressed: () async {
              if (isDownloaded) {
                await downloadService.openPodcast(widget.podcast);
              } else {
                await downloadService.downloadPodcast(
                  widget.podcast,
                  onReceiveProgress: (count, total) {
                    setState(() => progress = count / total);
                  },
                );
                _checkIfDownloaded();
                setState(() => progress = 0.0);
              }
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
