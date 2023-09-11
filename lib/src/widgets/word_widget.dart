import 'package:flutter/material.dart';

class WordWidget extends StatelessWidget {
  final bool isActivated;
  final String textContent;
  final Function onTap;

  const WordWidget({
    required this.isActivated,
    required this.textContent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        margin: const EdgeInsets.all(6.0),
        decoration: isActivated ? widgetDecoration() : widgetUnactiveDecoration(),
        child: Text(textContent),
      ),
    );
  }

  BoxDecoration widgetDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade50,
      border: Border.all(
        width: 1,
        color: Colors.grey.shade300
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10)
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.shade300,
          offset: const Offset(0.0, 4),
        ),
      ],
    );
  }

   BoxDecoration widgetUnactiveDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade300,
      border: Border.all(
        width: 1,
        color: Colors.grey.shade50
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10)
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.shade100,
          offset: const Offset(0.0, 4),
        ),
      ],
    );
  }
}