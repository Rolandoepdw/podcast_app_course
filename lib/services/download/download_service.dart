import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';

class DownloadService {
  final dio = Dio();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getPodcastFile(Podcast podcast) async {
    final path = await _localPath;
    final fileName = '${podcast.id}.mp3';
    return File('$path/Podcast App Course/${podcast.title}/$fileName');
  }

  Future<bool> isPodcastDownloaded(Podcast podcast) async {
    final file = await getPodcastFile(podcast);
    return file.exists();
  }

  Future<void> downloadPodcast(
    Podcast podcast, {
    ProgressCallback? onReceiveProgress,
  }) async {
    if (await isPodcastDownloaded(podcast)) return;

    final file = await getPodcastFile(podcast);
    await dio.download(
      podcast.audio,
      file.path,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<void> openPodcast(Podcast podcast) async {
    final file = await getPodcastFile(podcast);
    if (await file.exists()) {
      await OpenFile.open(file.path);
    }
  }
}
