import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_nest/features/home/model/like_model.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Color> colors = [Colors.red, Colors.blue, Colors.green];
  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LikeModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            //  height: 200,
            child: TikTokStyleFullPageScroller(
              contentSize: colors.length,
              swipePositionThreshold: 0.2,
              swipeVelocityThreshold: 2000,
              animationDuration: const Duration(milliseconds: 400),
              controller: controller,
              builder: (BuildContext context, int index) {
                return Container(
                  color: colors[index],
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
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

            // Container(
            //   height: 30,
            //   width: 80,

            //   child: Center(
            //     child: Text(
            //       'Log out',
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //   ),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //   ),
            // ),
          ),
          Positioned(
            bottom: 20,
            right: 5,
            child: Container(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      provider.togglelike();
                    },
                    icon: provider.islike
                        ? Icon(Icons.favorite, color: Colors.white, size: 35)
                        : Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCallbackEvent(
    ScrollDirection direction,
    ScrollSuccess success, {
    int? currentIndex,
  }) {
    print(
      "Scroll callback: direction=$direction, success=$success, index=${currentIndex ?? 'N/A'}",
    );
  }
}
