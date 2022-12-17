import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:provider/provider.dart';

import 'list_state.dart';

class SearchList extends StatefulWidget {
  final Color dropdownListColor;
  final Color dropdownListShadowColor;
  final double? dropdownListWidth;
  final TextStyle? dropdownListItemTextStyle;
  final ValueChanged<String> onSelect;
  final double dropdownListMargin;

  const SearchList({
    Key? key,
    this.dropdownListColor = Colors.grey,
    this.dropdownListShadowColor = Colors.grey,
    this.dropdownListWidth,
    this.dropdownListItemTextStyle,
    required this.onSelect,
    required this.dropdownListMargin,
  }) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ListState listState = context.watch<ListState>();
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    filter(String value) {
      List<ExtractedResult<String>> result =
          extractAllSorted(query: value, choices: listState.items);
      List<String> tmp = [];
      for (var element in result) {
        tmp.add(element.choice);
      }
      listState.setItems = tmp;
    }

    return Center(
      child: Card(
        // margin: EdgeInsets.all(widget.dropdownListMargin),
        child: Container(
          decoration: BoxDecoration(
            color: widget.dropdownListColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: widget.dropdownListShadowColor, blurRadius: 10),
            ],
          ),
          width: widget.dropdownListWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.search_rounded),
                    ),
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        ),
                        onChanged: (value) => filter(value),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: () => _textController.clear(),
                        child: const Icon(Icons.clear),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: mediaQueryData.size.height * 0.015,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: mediaQueryData.size.height * 0.66),
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  itemBuilder: (context, item) {
                    return ListTile(
                      hoverColor: Colors.grey,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: Text(
                          listState.items[item].toString(),
                          style: widget.dropdownListItemTextStyle,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      onTap: () {
                        listState.setSelection = listState.items[item];
                        print("selected ${listState.selection}");
                        widget.onSelect(listState.selection);
                        Navigator.pop(context);
                      },
                    );
                  },
                  shrinkWrap: true,
                  itemCount: listState.items.length,
                ),
              ),
              SizedBox(
                height: mediaQueryData.size.height * 0.015,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all(widget.dropdownListColor),
                      elevation: MaterialStateProperty.all(0),
                      textStyle: const MaterialStatePropertyAll(
                        TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
