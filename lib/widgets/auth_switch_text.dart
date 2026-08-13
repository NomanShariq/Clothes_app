import 'package:flutter/material.dart';

class AuthSwitchText extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onTap;

  const AuthSwitchText({
    Key? key,
    required this.question,
    required this.actionText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
