import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color background;
  final String text;
  final Color textColor;
  final Color? borderColor;
  final Widget? icon;
  final VoidCallback? onTap;
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
        margin: const EdgeInsets.symmetric(vertical: 2),
        color: background,
        child: SizedBox(
          height: 36,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                if (icon != null) Center(child: icon!),
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
      ),
      onTap: onTap,
    );
  }
}

class AppleLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

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
      icon: Image(
        image: AssetImage(
          'images/signin_button_apple.png',
          package: 'custom_widgets',
        ),
        width: 24,
        height: 24,
      ),
      onTap: onTap,
    );
  }
}

class FacebookLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

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
      icon: Image(
        image: AssetImage(
          'images/signin_button_facebook.png',
          package: 'custom_widgets',
        ),
        width: 24,
        height: 24,
      ),
      onTap: onTap,
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

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
      icon: Image(
        image: AssetImage(
          'images/signin_button_google.png',
          package: 'custom_widgets',
        ),
        width: 24,
        height: 24,
      ),
      onTap: onTap,
    );
  }
}
