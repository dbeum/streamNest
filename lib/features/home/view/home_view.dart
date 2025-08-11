import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:stream_nest/features/home/model/like_model.dart';
import 'package:stream_nest/features/home/model/pause_model.dart';
import 'package:stream_nest/features/home/model/video_model.dart';
import 'package:stream_nest/features/home/service/home_service.dart';
import 'package:stream_nest/features/home/widget/video_player_widget.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<VideoModel>> _videoFuture;
  final PageController pageController = PageController();
  int currentIndex = 0;
  List<VideoModel> videos = [];

  @override
  void initState() {
    super.initState();
    _videoFuture = fetchVideoModel();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LikeModel>(context);
    final pauseProvider = Provider.of<pauseModel>(context);
    return Scaffold(
      body: FutureBuilder<List<VideoModel>>(
        future: _videoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error in FutureBuilder: ${snapshot.error}');
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final videos = snapshot.data!;
            return Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return GestureDetector(
                      onTap: () {
                        pauseProvider.togglepause();
                      },
                      child: Stack(
                        children: [
                          VideoPlayerWidget(
                            url: video.videoUrl,
                            isActive: index == currentIndex,
                            isPaused: pauseProvider.ispaused,
                          ),

                          if (pauseProvider.ispaused)
                            Center(
                              child: Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 100,
                              ),
                            ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${video.userName}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4,
                                        color: Colors.black54,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${video.title}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,

                                    shadows: [
                                      Shadow(
                                        blurRadius: 4,
                                        color: Colors.black54,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  height: 200,
                  child: Text(
                    'StreamNest',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 5,
                  child: Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.togglelike();
                          },
                          icon: provider.islike
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 40,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                  size: 40,
                                ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.sms, color: Colors.white, size: 35),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
