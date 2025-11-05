import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastApi {
  final dio = Dio();

  PodcastApi() {
    dio.options.maxRedirects = 10;
  }

  Future<List<Podcast>> fetchPodcasts() async {
    const url = 'https://listen-api.listennotes.com/api/v2/search?q=star';
    const apiKey = 'd6d65f805c6a4f3c8e2670057317cf35';
    final headers = {'X-ListenAPI-Key': apiKey, 'Accept': 'application/json'};

    if (await InternetConnectionChecker.instance.hasConnection) {
      final response = await dio.get(url, options: Options(headers: headers));
      final results = response.data['results'] as List;
      final podcasts = results.map((json) => Podcast.fromJson(json)).toList();
      return podcasts;
    } else {
      return [];
    }
  }

  Future<void> downloadPodcast(
    String url,
    String fileName, {
    ProgressCallback? onReceiveProgress,
  }) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final sharedPreferences = await SharedPreferences.getInstance();
    final downloadPath = '${appStorage.path}/$fileName';

    if (await InternetConnectionChecker.instance.hasConnection) {
      await dio.download(
        url,
        downloadPath,
        onReceiveProgress: onReceiveProgress,
      );
      await sharedPreferences.setString('path', downloadPath);
    }
  }
}
