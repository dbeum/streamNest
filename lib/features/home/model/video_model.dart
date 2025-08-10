class VideoModel {
  final String title;
  final String description;
  final String genre;
  final String userName;
  final String videoUrl;
  VideoModel({
    required this.title,
    required this.description,
    required this.genre,
    required this.userName,
    required this.videoUrl,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      genre: json['genre'] ?? '',
      userName: json['userName'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
    );
  }
}
