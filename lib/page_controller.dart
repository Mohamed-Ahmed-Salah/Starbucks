import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OffsetController extends ChangeNotifier {
  double pageOffset = 0.0;

  bool notInInitialIndex = false;

  changeOffset(double? newOffset) {
    pageOffset = newOffset ?? 0;
    if (pageOffset >= 1) {
      notInInitialIndex = true;
    }
    notifyListeners();
  }
}
