import 'package:app/components/spotify_webview_page.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late String username;
  HomePage({required username, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer Playlist")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            SpotifyAuth(widget.username);
          },
          child: Text("Select Source"),
        ),
      ),
    );
  }
}
