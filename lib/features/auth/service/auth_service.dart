import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stream_nest/features/auth/service/auth_model.dart';
import 'package:stream_nest/features/home/model/video_model.dart';

Future<bool> refreshTokens() async {
  final refreshToken = await TokenStorage.getRefreshToken();
  if (refreshToken == null) return false;

  final response = await http.post(
    Uri.parse('https://streamnest-880k.onrender.com/api/auth/refresh'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'refresh_token': refreshToken}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await TokenStorage.saveTokens(
      data['access_token'],
      data['refresh_token'] ?? refreshToken,
    );
    print('Tokens refreshed!');
    return true;
  } else {
    print('Failed to refresh tokens.');
    return false;
  }
}

Future<List<VideoModel>> fetchVideoModel() async {
  String? accessToken = await TokenStorage.getAccessToken();

  http.Response response = await http.get(
    Uri.parse('https://streamnest-880k.onrender.com/api/VideoPosts'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List jsonList = jsonDecode(response.body);
    return jsonList.map((json) => VideoModel.fromJson(json)).toList();
  } else if (response.statusCode == 401) {
    bool refreshed = await refreshTokens();
    if (refreshed) {
      accessToken = await TokenStorage.getAccessToken();
      response = await http.get(
        Uri.parse('https://streamnest-880k.onrender.com/api/VideoPosts'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => VideoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed after token refresh: ${response.statusCode}');
      }
    } else {
      throw Exception('Refresh token expired, login required.');
    }
  } else {
    throw Exception('Failed to load videos: ${response.statusCode}');
  }
}
