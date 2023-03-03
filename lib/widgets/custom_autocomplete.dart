import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/utils/styles.dart';

class CustomAutocomplete extends StatelessWidget {
  const CustomAutocomplete({super.key, this.list = const [], this.label = ''});

  final String label;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Styles.primaryColor),
            textAlign: TextAlign.left,
          ),
          const Gap(5),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              if (list.length > 0){
                return list.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
              });
              }
              return [];
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) =>
                    TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0, left: 10),
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 500),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Styles.accentColor, width: 1.0),
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
                print('You just typed a new entry  $value');
              },
            ),
            optionsViewBuilder: (context, onAutoCompleteSelect, options) {
              return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    // size works, when placed here below the Material widget
                    child: Container(
                        // I have the text field wrapped in a container with
                        // EdgeInsets.all(20) so subtract 40 from the width for the width
                        // of the text box. You could also just use a padding widget
                        // with EdgeInsets.only(right: 20)
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: options.length,
                          separatorBuilder: (context, i) {
                            return Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Text('${list[index]}');
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
