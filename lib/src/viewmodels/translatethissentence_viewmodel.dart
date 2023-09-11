import 'dart:math';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translatethissentence/src/models/word_model.dart';

final translateThisSentenceProvider = ChangeNotifierProvider(
  (ref) => TranslateThisSentence()
);

class TranslateThisSentence extends ChangeNotifier {
  late List<String> stringTranslatedSentence;
  late List<Word> wordTranslatedSentence;
  late List<Word> wordSentence;
  late String sentence;
  late String answer;

  void initViewModel(Map<String,String> sentences, bool chosenLanguage){
    List<String> stringSentence = sentences[language(chosenLanguage)]!.split(' ');
    answer = sentences[language(chosenLanguage)]!;
    sentence = sentences[language(!chosenLanguage)]!;
    stringTranslatedSentence = [];
    wordTranslatedSentence = [];

    stringSentence.shuffle(Random(3));
    wordSentence = List.generate(
      stringSentence.length,
      (index) => Word(
        textContent: stringSentence[index],
        id: index
      )
    );
  }

  String language(bool value){
    return value ? 'languageOne' : 'languageTwo';
  }

  void selectWordIntoWordSentence(int index){
    Word word = wordSentence.where((element) => element.id == index).first;

    if(word.isActivated){
      word.isActivated = false;
      wordTranslatedSentence.add(Word(textContent: word.textContent, id: word.id));
      stringTranslatedSentence.add(word.textContent);
    }

    notifyListeners();
  }

  void selectWordIntoWordTranslatedSentence(int index){
    Word word = wordTranslatedSentence[index];
    stringTranslatedSentence.removeWhere((element) => element == word.textContent);
    wordTranslatedSentence.removeWhere((element) => element == word);

    word = wordSentence.where((element) => element.id == word.id).first;
    word.isActivated = true;
    notifyListeners();
  }

  bool isFinished(){
    return wordSentence.length == wordTranslatedSentence.length;
  }

  bool isSucceded(){
    return answer == stringTranslatedSentence.reduce((value, element) => '$value $element');
  }
}
