import 'package:flutter/material.dart';

class PodcastItem extends StatefulWidget {
  const PodcastItem({super.key});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Podcast title'),
      trailing: IconButton(icon: const Icon(Icons.download), onPressed: () {}),
      leading: Image.network(
        'https://picsum.photos/100/100',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
