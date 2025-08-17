import 'package:flutter/widgets.dart';

class pauseModel with ChangeNotifier {
  bool ispaused = false;
  void togglepause() {
    ispaused = !ispaused;
    notifyListeners();
  }
}
