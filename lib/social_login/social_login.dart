import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color background;
  final String text;
  final Color textColor;
  final Color? borderColor;
  final Widget? icon;
  final VoidCallback onTap;
  final TextAlign? textAlign;

  const LoginButton({
    Key? key,
    required this.background,
    required this.text,
    this.textColor = Colors.white,
    this.borderColor,
    this.icon,
    required this.onTap,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: borderColor ?? background, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              if (icon != null) icon!,
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  textAlign: textAlign,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

class AppleLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AppleLoginButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      background: Colors.black,
      text: text,
      borderColor: Colors.white,
      icon: const Icon(Icons.face, color: Colors.white, size: 18),
      onTap: onTap,
    );
  }
}

class FacebookLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const FacebookLoginButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      background: const Color(0xFF3b5998),
      text: text,
      icon: const Icon(Icons.face, color: Colors.white, size: 18),
      onTap: onTap,
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GoogleLoginButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      background: Colors.white,
      text: text,
      textColor: Colors.black,
      icon: const Icon(Icons.face, color: Colors.black, size: 18),
      onTap: onTap,
    );
  }
}
