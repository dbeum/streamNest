import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stream_nest/features/home/model/video_model.dart';

// String accessToken =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ijc0NDUwNzRkLTVlNjUtNGJlZS1hYTZhLTQ1YWQ5OTIzMjdiMCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJTdHJlYW1uZXN0IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQ29uc3VtZXIiLCJleHAiOjE3NTQ5MDQwNzAsImlzcyI6IlN0cmVhbU5lc3QuQXBpIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjEzIn0.LxkBsDOUmHl6IZa_lwPpP640g0khNhR8DSuy-A1vrRI';
// String refreshToken = 'OMF1m7xdd1+YiLMeqjmUmsfyfJQunNJTGuQKG3sd5/k=';

// Future<bool> refreshTokens() async {
//   final response = await http.post(
//     Uri.parse('https://streamnest-880k.onrender.com/api/auth/refresh'),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'refresh_token': refreshToken}),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     accessToken = data['access_token'];
//     refreshToken = data['refresh_token'] ?? refreshToken;
//     print('Tokens refreshed!');
//     return true;
//   } else {
//     print('Failed to refresh tokens.');
//     return false;
//   }
// }

Future<List<VideoModel>> fetchVideoModel() async {
  final Storage = FlutterSecureStorage();
  String? accessToken = await Storage.read(key: 'accessToken');
  String? refreshToken = await Storage.read(key: 'refreshToken');

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
    // } else if (response.statusCode == 401) {
    //   bool refreshed = await refreshTokens();
    //   if (refreshed) {
    //     response = await http.get(
    //       Uri.parse('https://streamnest-880k.onrender.com/api/VideoPosts'),
    //       headers: {
    //         'Authorization': 'Bearer $accessToken',
    //         'Accept': 'application/json',
    //       },
    //     );
    //     if (response.statusCode == 200) {
    //       final List jsonList = jsonDecode(response.body);
    //       return jsonList.map((json) => VideoModel.fromJson(json)).toList();
    //     } else {
    //       throw Exception('Failed after token refresh: ${response.statusCode}');
    //     }
    //   } else {
    //     throw Exception('Refresh token expired, login required.');
    //   }
  } else {
    throw Exception('Failed to load videos: ${response.statusCode}');
  }
}
