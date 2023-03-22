import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/themes/styles.dart';

typedef OnTap = void Function(FocusNode focusNode);
typedef OnTapOutside = void Function();
typedef OnSelected = void Function(String value);

class CustomAutocomplete extends StatefulWidget {
  const CustomAutocomplete(
      {super.key,
      this.list = const [],
      this.label = '',
      this.onTap,
      this.stopDetectingTapOutside = false,
      this.onTapOutside,
      this.onSelected,
      this.initValue = '',
      this.focusNode});

  final bool? stopDetectingTapOutside;
  final String initValue;
  final OnTap? onTap;
  final OnSelected? onSelected;
  final OnTapOutside? onTapOutside;
  final String label;
  final List<String> list;
  final FocusNode? focusNode;
  @override
  State<StatefulWidget> createState() {
    return CustomAutocompleteState();
  }
}

class CustomAutocompleteState extends State<CustomAutocomplete> {
  FocusNode _focusNode = FocusNode();
  bool _expanded = false;

  void getFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(fontSize: 10, color: Styles.primaryColor),
            textAlign: TextAlign.left,
          ),
          const Gap(5),
          Autocomplete<String>(
            optionsMaxHeight: 50,
            initialValue: TextEditingValue(text: widget.initValue),
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                setState(() {
                  _expanded = false;
                });
                return const Iterable<String>.empty();
              }
              if (widget.list.isNotEmpty) {
                return widget.list.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              }
              return [];
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                onTapOutside: (onTapOut) {
                  if (!widget.stopDetectingTapOutside!) {
                    widget.onTapOutside?.call();
                    onTapOut.down;
                  }
                },
                onEditingComplete: () {
                  setState(() {
                    _focusNode = focusNode;
                  });
                  if (!widget.stopDetectingTapOutside!) {
                    widget.onTapOutside?.call();
                  }
                },
                onTap: () {
                  setState(() {
                    _focusNode = focusNode;
                  });
                  widget.onTap?.call(_focusNode);
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 0, left: 10),
                  suffixIconColor: Styles.primaryColor,
                  suffixIcon: Icon(_expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  constraints: const BoxConstraints(
                    maxHeight: 30,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Styles.accentColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: BorderSide(
                      color: Styles.primaryColor,
                      width: 1.0,
                    ),
                  ),
                ),
                focusNode: focusNode,
                onFieldSubmitted: (String value) {
                  onFieldSubmitted();
                  setState(() {
                    _focusNode = focusNode;
                  });
                  widget.onTapOutside?.call();
                },
              );
            },
            optionsViewBuilder: (context, onAutoCompleteSelect, options) {
              return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: 500, maxWidth: 250),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: options.length,
                          separatorBuilder: (context, i) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final option = options.elementAt(index);
                            return InkWell(
                              onTap: () {
                                onAutoCompleteSelect(option);
                                widget.onSelected?.call(option);
                              },
                              child: Builder(builder: (BuildContext context) {
                                final bool highlight =
                                    AutocompleteHighlightedOption.of(context) ==
                                        index;
                                if (highlight) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback(
                                          (Duration timeStamp) {
                                    Scrollable.ensureVisible(context,
                                        alignment: 0.5);
                                  });
                                }
                                return Container(
                                  color: highlight
                                      ? Theme.of(context).focusColor
                                      : null,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(option),
                                );
                              }),
                            );
                          },
                        )),
                  ));
            },
            onSelected: (String selection) {
              debugPrint('You just selected $selection');
            },
          ),
        ]);
  }
}
