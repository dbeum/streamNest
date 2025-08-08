import 'package:flutter/cupertino.dart';

class LikeModel with ChangeNotifier {
  bool islike = false;

  void togglelike() {
    islike = !islike;
    notifyListeners();
  }
}
