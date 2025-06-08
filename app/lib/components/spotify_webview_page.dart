import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

Future<void> SpotifyAuth(String username) async {
  try {
    final result = await FlutterWebAuth2.authenticate(
      url:
          "https://treaty-voices-accommodations-jumping.trycloudflare.com Play-T/transfer/api/spotify/auth",
      callbackUrlScheme: "myapp",
    );

    final accessToken = Uri.parse(result).queryParameters['access_token'];
    final refreshToken = Uri.parse(result).queryParameters['refresh_token'];
    final expiryAt = Uri.parse(result).queryParameters['expiryAt'];

    print("spotify auth function is complete");

    print("spotify current user tocken : $accessToken");

    if (accessToken != null) {
      storeInUserDatabase(accessToken, refreshToken!, expiryAt!, username);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> storeInUserDatabase(
  String accessToken,
  String refreshToken,
  String expiryAt,
  String username,
) async {
  const String url =
      "http://10.0.2.2:3000/Play-T/transfer/api/spotify/auth/user/token/store";

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'json/application'},
      body: jsonEncode({
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiryAt': expiryAt,
        'username': username,
      }),
    );
  } catch (e) {
    print(e);
  }
}
