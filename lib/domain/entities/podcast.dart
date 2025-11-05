class Podcast {
  final String audio;
  final String image;
  final String title;
  final String id;

  const Podcast({
    required this.audio,
    required this.image,
    required this.title,
    required this.id,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      audio: json['audio'],
      image: json['image'],
      title: json['title_original'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'audio': audio, 'image': image, 'title_original': title, 'id': id};
  }
}
