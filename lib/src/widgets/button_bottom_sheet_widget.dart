import 'package:flutter/material.dart';

class ButtonBottomSheetWidget extends StatelessWidget {
  final bool type;
  final Widget actionButton;
  final String feedbackMessage;
  final String answer;

  const ButtonBottomSheetWidget({
    this.type = true,
    required this.actionButton,
    required this.feedbackMessage,
    required this.answer
  });

  @override
  Widget build(BuildContext context) {
    Color bottomTypeColorBackground = type ? Colors.green.shade100 : Colors.red.shade100;
    Color bottomTypeColorText = type ? Colors.green.shade600 : Colors.red.shade600;

    return Container(
      height: MediaQuery.of(context).size.height*.2,
      decoration: BoxDecoration(
        color: bottomTypeColorBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(20)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          type
          ? goodAnswer(feedbackMessage, bottomTypeColorText)
          : wrongAnswer(context, bottomTypeColorText),
          actionButton
        ],
      )
    );
  }

  Padding wrongAnswer(BuildContext context, Color bottomTypeColorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Correct answer:',
              style: TextStyle(
                color: bottomTypeColorText,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
            Text(
              answer,
              style: TextStyle(
                color: bottomTypeColorText,
                fontSize: 18
              ),
            ),
          ],
        ),
      ),
  );
  }

  Padding goodAnswer(String theFeedbackMessage, Color bottomTypeColorText) {
    return Padding(
      padding: const EdgeInsets.only(
        top:12.0,
        right: 12.0,
        left: 12.0
      ),
      child: Text(
        theFeedbackMessage,
        style: TextStyle(
          color: bottomTypeColorText,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
      ),
    );
  }

  Container bottomBottomSheetWidget(BuildContext context, bool type, Color bottomTypeColorBackground) {
    return Container(
      height: MediaQuery.of(context).size.height*0.12,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        ),
        color: bottomTypeColorBackground,
      ),
      child: actionButton
    );
  }
}