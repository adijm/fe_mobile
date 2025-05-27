import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.facebook),
          onPressed: null, // TODO: Facebook login
        ),
        SizedBox(width: 16),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.google),
          onPressed: null, // TODO: Google login
        ),
        SizedBox(width: 16),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.apple),
          onPressed: null, // TODO: Apple login
        ),
      ],
    );
  }
}
