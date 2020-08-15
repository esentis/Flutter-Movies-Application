import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteArticlesState extends ChangeNotifier {
  int counter;
  List<ListTile> widgetsToDraw;
  FavoriteArticlesState({
    this.counter,
    this.widgetsToDraw,
  });
  void getCounter() => counter;
  void getWidgets() => widgetsToDraw;
  void setCounter(number) {
    counter = number;
    notifyListeners();
  }

  void addWidget(ListTile tile) {
    widgetsToDraw.add(tile);
    notifyListeners();
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
