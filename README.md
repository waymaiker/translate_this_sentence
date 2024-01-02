<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package is useful when you are trying to construct a test or quiz and check the user's ability to define or translate a sentence.
I'm currently developping a learning app and it's one of the package I already developped (There are 9 of them)

## Features
Select each option in a particular order  
Either you find the right combination or you don't, and the answer is given to you.

<img src="https://github.com/waymaiker/translate_this_sentence/blob/main/translate%20this%20sentence%20-%20view.png" alt="exercice view" width="200"/> <img src="https://github.com/waymaiker/translate_this_sentence/blob/main/translate%20this%20sentence%20-%20before%20submitting.png" alt="before submitting answer view" width="200"/> <img src="https://github.com/waymaiker/translate_this_sentence/blob/main/translate%20this%20sentence%20-%20wrong%20answer.png" alt="wrong answer view" width="200"/> <img src="https://github.com/waymaiker/translate_this_sentence/blob/main/translate%20this%20sentence%20-%20good%20answer.png" alt="good answer view" width="200"/>

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:translatethissentence/translatethissentence.dart';

class MyQuizComponent extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final questions = [
     {
       "id": 0,
       "sentences": {"languageOne": "Ana sa yaay", 'languageTwo':'Comment va ta mère'},
       "title": "Translate this sentence",
       "type": "translatethissentence",
       "result": -1
     },
    ]

    final questionIndex = useState(0);

    bool isNotLastQuestion(){
      return questionIndex.value < questions.length - 1;
    }

    void nextQuestion(){
      isNotLastQuestion()
        ? questionIndex.value++
        : GoRouter.of(context).go('/results');
    }

    useEffect(() {}, [questions]);

    return OverrideBackButtonWrapperWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: TranslateThisSentence(
          titleButton: 'NEXT',
          title: questions[questionIndex.value]["title"],
          sentences: questions[questionIndex.value]["sentences"],
          feedbackMessage: "Well done", // When the user has the right answer
          setQuestionResult: () => {}, // get the result of the question
          action: () => nextQuestion(), // What you want to happen when you click on the bottom sheet button
        )
      )
    );
  }
}

```

## Additional information

- [ ] Unit tests
- [ ] Integration tests
