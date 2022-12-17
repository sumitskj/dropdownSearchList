library dropdown_search_list;

import 'package:dropdown_search_list/search_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_state.dart';

class DropdownSearchList extends StatelessWidget {
  final List<String> items;
  final double? dropdownListButtonHeight;
  final double? dropdownListButtonWidth;
  final BoxDecoration? dropdownListButtonDecoration;
  final Icon dropdownListButtonIcon;
  final String dropdownListButtonInitialText;
  final Color dropdownListColor;
  final Color dropdownListShadowColor;
  final double? dropdownListWidth;
  final TextStyle? dropdownListItemTextStyle;
  final ValueChanged<String> onSelect;
  final double dropdownListMargin;

  const DropdownSearchList({
    Key? key,
    required this.items,
    this.dropdownListButtonHeight,
    this.dropdownListButtonWidth,
    this.dropdownListButtonDecoration,
    this.dropdownListButtonIcon = const Icon(Icons.arrow_downward),
    required this.dropdownListButtonInitialText,
    this.dropdownListColor = Colors.grey,
    this.dropdownListShadowColor = Colors.grey,
    this.dropdownListWidth,
    this.dropdownListItemTextStyle,
    this.dropdownListMargin = 6,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListState(dropdownListButtonInitialText, items),
      child: SearchableListDropdownButton(
        dropdownListButtonHeight: dropdownListButtonHeight,
        dropdownListButtonWidth: dropdownListButtonWidth,
        dropdownListButtonDecoration: dropdownListButtonDecoration,
        dropdownListColor: dropdownListColor,
        dropdownListItemTextStyle: dropdownListItemTextStyle,
        dropdownListShadowColor: dropdownListShadowColor,
        dropdownListWidth: dropdownListWidth,
        dropdownListButtonIcon: dropdownListButtonIcon,
        dropdownListMargin: dropdownListMargin,
        onSelect: onSelect,
      ),
    );
  }
}

class SearchableListDropdownButton extends StatefulWidget {
  final double? dropdownListButtonHeight;
  final double? dropdownListButtonWidth;
  final BoxDecoration? dropdownListButtonDecoration;
  final Icon dropdownListButtonIcon;
  final Color dropdownListColor;
  final Color dropdownListShadowColor;
  final double? dropdownListWidth;
  final TextStyle? dropdownListItemTextStyle;
  final ValueChanged<String> onSelect;
  final double dropdownListMargin;

  const SearchableListDropdownButton({
    Key? key,
    this.dropdownListButtonHeight,
    this.dropdownListButtonWidth,
    this.dropdownListButtonDecoration,
    this.dropdownListButtonIcon = const Icon(Icons.arrow_downward),
    this.dropdownListColor = Colors.grey,
    this.dropdownListShadowColor = Colors.grey,
    this.dropdownListWidth,
    this.dropdownListItemTextStyle,
    required this.onSelect,
    required this.dropdownListMargin,
  }) : super(key: key);

  @override
  State<SearchableListDropdownButton> createState() =>
      _SearchableListDropdownButtonState();
}

class _SearchableListDropdownButtonState
    extends State<SearchableListDropdownButton> {
  @override
  Widget build(BuildContext context) {
    ListState listState = context.watch<ListState>();

    return Container(
      height: widget.dropdownListButtonHeight,
      width: widget.dropdownListButtonWidth,
      padding: const EdgeInsets.all(8),
      decoration: widget.dropdownListButtonDecoration,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            DialogRoute(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return ListenableProvider(
                    create: (context) => listState,
                    child: SearchList(
                      dropdownListColor: widget.dropdownListColor,
                      dropdownListItemTextStyle:
                      widget.dropdownListItemTextStyle,
                      dropdownListShadowColor:
                      widget.dropdownListShadowColor,
                      dropdownListWidth: widget.dropdownListWidth,
                      dropdownListMargin: widget.dropdownListMargin,
                      onSelect: widget.onSelect,
                    ),
                  );
                }),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Center(
                  child: Text(
                    listState.selection,
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: widget.dropdownListButtonIcon,
            ),
          ],
        ),
      ),
    );
  }
}
