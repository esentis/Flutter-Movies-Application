import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetLoading extends ChangeNotifier {
  bool isLoading;

  SetLoading({
    this.isLoading,
  });
  void getStatus() => isLoading;

  void toggleLoading() {
    if (isLoading) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    notifyListeners();
  }
}
