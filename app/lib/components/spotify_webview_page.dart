import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

Future<void> SpotifyAuth() async {
  try {
    final result = await FlutterWebAuth2.authenticate(
      url:
          "https://completed-want-main-hall.trycloudflare.com/Play-T/transfer/api/spotify/auth",
      callbackUrlScheme: "myapp",
    );

    final token = Uri.parse(result).queryParameters['token'];

    print("spotify auth function is complete");

    print("spotify current user tocken : $token");
  } catch (e) {
    print(e);
  }
}
