import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:translatethissentence/src/viewmodels/translatethissentence_viewmodel.dart';
import 'package:translatethissentence/src/widgets/button_bottom_sheet_widget.dart';
import 'package:translatethissentence/src/widgets/phrase_widget.dart';
import 'package:translatethissentence/src/widgets/principal_button_widget.dart';
import 'package:translatethissentence/src/widgets/text_widget.dart';

class TranslateThisSentence extends HookWidget {
  final Map<String,String> sentences;
  final Function setQuestionResult;
  final Function action;
  final String title;
  final String titleButton;
  final String titleButtonSheet;
  final String feedbackMessage;

  TranslateThisSentence({
    required this.setQuestionResult,
    required this.sentences,
    required this.action,
    this.title = 'Translate this sentence',
    this.titleButton = 'NEXT',
    this.titleButtonSheet = 'NEXT',
    this.feedbackMessage = 'SUPER'
  }) : assert(sentences.isNotEmpty == true);

  @override
  Widget build(BuildContext context) {
    final viewmodel = useProvider(translateThisSentenceProvider);
    late PersistentBottomSheetController buttonBottomSheet;
    var randomLanguage = useState(false);

    // Initialize the viewmodel
    useEffect((){
      randomLanguage.value = Random().nextBool();
      viewmodel.initViewModel(sentences, randomLanguage.value);
    }, []);

    // Initialize the component
    useEffect((){}, [viewmodel.stringTranslatedSentence]);

    void closeButtonBottomSheet(){
      buttonBottomSheet.close();
    }

    void showButtonBottomSheet(BuildContext context) {
      buttonBottomSheet = showBottomSheet<void>(
        context: context,
        builder: (context) {
          return ButtonBottomSheetWidget(
            type: viewmodel.isSucceded(),
            answer: viewmodel.answer,
            feedbackMessage: feedbackMessage,
            actionButton:  PrincipalButtonWidget(
              action: () {
                action();
                closeButtonBottomSheet();
              },
              title: titleButtonSheet,
              type: viewmodel.isSucceded() ? 'goodAnswer' : 'wrongAnswer'
            )
          );
        }
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(title: title, fontSize: 22),
          SizedBox(height: MediaQuery.of(context).size.height*0.01),
          TextWidget(title: viewmodel.sentence, fontSize: 18),
          SizedBox(height: MediaQuery.of(context).size.height*0.08),
          PhraseWidget(
            sentence: viewmodel.wordTranslatedSentence,
            onTapAction: viewmodel.selectWordIntoWordTranslatedSentence,
          ),
          PhraseWidget(
            sentence: viewmodel.wordSentence,
            onTapAction: viewmodel.selectWordIntoWordSentence,
          ),
          PrincipalButtonWidget(
            title: titleButton,
            action: () => {
              setQuestionResult(viewmodel.isSucceded()),
              showButtonBottomSheet(context)
            },
            type: viewmodel.isFinished() ? 'enabled' : 'default',
          ),
        ],
      ),
    );
  }
}