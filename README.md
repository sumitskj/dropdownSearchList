**Flutter DropdownSearchList**

Simple and robust dropdown search list widget package for flutter.
## Features

Create easy to manage dropdown scrollable search list.
Feature to let the user search through a keyword string which finds matching items using the fuzzy search and then show the items.


## Usage

**pubspec.yaml**

```dart
dependencies:
  dropdown_search_list: ^0.0.1
```


## Example

![List Button](https://github.com/sumitskj/resources/blob/main/Images/listBtn.png?raw=true)
![List Button](https://github.com/sumitskj/resources/blob/main/Images/openList.png?raw=true)

<h1 style="color: #80aaff">lib/main.dart</h1>

```dart
import 'package:dropdown_searchable_list/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 4,
          color: Colors.black,
          style: BorderStyle.solid,
        ));

    List<String> items = [
      'Bicycling, Competitive',
      'Bicycling Uphill',
      'Bicycle Race',
      'Mountain Biking',

    ];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        items: items,
        dropdownListButtonHeight: 50,
        dropdownListButtonWidth: 400,
        dropdownListButtonDecoration: decoration,
        dropdownListButtonInitialText: 'Select',
      ),
    );
  }
}

```

<h1 style="color: #80aaff">lib/list_state.dart</h1>

```dart

import 'package:flutter/cupertino.dart';

class ListState extends ChangeNotifier {
  late bool open;
  late String selection;
  late List<String> items;

  bool get getOpen {
    return open;
  }

  set setOpen(bool open) {
    this.open = open;
    notifyListeners();
  }

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

  ListState(this.open, this.selection, this.items);

}

```


<h1 style="color: #80aaff">lib/home.dart</h1>

```dart
import 'package:dropdown_search_list/dropdown_search_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<String> items;
  final double? dropdownListButtonHeight;
  final double? dropdownListButtonWidth;
  final BoxDecoration? dropdownListButtonDecoration;
  final Icon dropdownListButtonIcon;
  final String dropdownListButtonInitialText;

  const HomePage({
    Key? key,
    required this.items,
    this.dropdownListButtonHeight,
    this.dropdownListButtonWidth,
    this.dropdownListButtonDecoration,
    this.dropdownListButtonIcon = const Icon(Icons.arrow_downward),
    required this.dropdownListButtonInitialText,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedData = "Nothing selected";

  @override
  Widget build(BuildContext context) {

    updateText(String value){
      setState(() {
        selectedData = value;
        print("Updating text data " + selectedData);
      });
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(selectedData),
            Container(
              width: 300,
              height: 50,
              child: DropdownSearchList(
                items: widget.items,
                dropdownListButtonInitialText: "Please select any option",
                dropdownListButtonDecoration: widget.dropdownListButtonDecoration,
                dropdownListButtonWidth: widget.dropdownListButtonWidth,
                dropdownListButtonHeight: widget.dropdownListButtonHeight,
                dropdownListButtonIcon: Icon(Icons.arrow_drop_down),
                dropdownListWidth: 500,
                dropdownListShadowColor: Colors.grey,
                dropdownListColor: Colors.grey.shade200,
                onSelect: (value) => updateText(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

<p>
Follow our blogs on Flutter : https://blog.toptime.club
Want to Interact with an influencer, book call at : https://www.toptime.club/
</p>