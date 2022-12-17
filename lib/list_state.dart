import 'package:flutter/cupertino.dart';

class ListState extends ChangeNotifier {
  late String selection;
  late List<String> items;


  String get getSelection {
    return selection;
  }

  set setSelection(String selection) {
    this.selection = selection;
    notifyListeners();
  }

  List<String> get getItems {
    return items;
  }

  set setItems(List<String> items) {
    this.items = items;
    notifyListeners();
  }

  set addItems(String item) {
    items.add(item);
    notifyListeners();
  }

  ListState(this.selection, this.items);

}
