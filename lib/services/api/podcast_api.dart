import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:podcast_app_course/domain/entities/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastApi {
  final dio = Dio();

  PodcastApi() {
    dio.options.maxRedirects = 10;
  }

  Future<List<Podcast>> fetchPodcasts() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    const url = 'https://listen-api.listennotes.com/api/v2/search?q=star';
    const apiKey = 'd6d65f805c6a4f3c8e2670057317cf35';
    final headers = {'X-ListenAPI-Key': apiKey, 'Accept': 'application/json'};

    if (await InternetConnectionChecker.instance.hasConnection) {
      final response = await dio.get(url, options: Options(headers: headers));
      final results = response.data['results'] as List;
      final podcasts = results.map((json) => Podcast.fromJson(json)).toList();
      await sharedPreferences.setString('podcasts', jsonEncode(podcasts));
      return podcasts;
    } else {
      final podcasts = sharedPreferences.getString('podcasts');
      if (podcasts == null) {
        return [];
      } else {
        return jsonDecode(
          podcasts,
        ).map((json) => Podcast.fromJson(json)).toList();
      }
    }
  }
}
