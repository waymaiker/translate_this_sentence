import 'package:flutter/material.dart';

import 'package:translatethissentence/src/models/word_model.dart';
import 'package:translatethissentence/src/widgets/word_widget.dart';

class PhraseWidget extends StatelessWidget {
  final List<Word> sentence;
  final Function onTapAction;
  bool centered;

  PhraseWidget({
    required this.sentence,
    required this.onTapAction,
    this.centered = true
  });

  @override
  Widget build(BuildContext context) {
    List<WordWidget> words = [];
    List.generate(
      sentence.length,
      (index){
        bool isActivated = sentence[index].isActivated;
        String text = isActivated
          ? sentence[index].textContent
          : List.filled(sentence[index].textContent.length, ' ').join('');

        return words.add(
          WordWidget(
            isActivated: isActivated,
            textContent: text,
            onTap: isActivated ? () => onTapAction(index) : () => {}
          )
        );
      }
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.32,
      child: Wrap(
        alignment: centered ? WrapAlignment.center : WrapAlignment.start,
        children: words
      ),
    );
  }
}