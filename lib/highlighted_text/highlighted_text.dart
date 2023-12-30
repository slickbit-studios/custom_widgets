import 'package:custom_widgets/highlighted_text/ascii_tokenizer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? textAlign;
  final Map<String, Color> colors;
  final Color urlColor;
  late final List<TextSpan> texts;
  final void Function(String)? launchUrl;

  HighlightedText(
    String text, {
    super.key,
    this.style,
    this.textAlign,
    this.urlColor = Colors.blue,
    this.colors = const {
      'black': Colors.black,
      'white': Colors.white,
    },
    this.launchUrl,
  }) {
    List<TextSegment> segments = AsciiTextTokenizer().parse(text);
    texts = _getTextSpans(segments);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: texts, style: style),
      textAlign: textAlign ?? TextAlign.start,
    );
  }

  List<TextSpan> _getTextSpans(List<TextSegment> segments) {
    List<TextSpan> result = [];

    for (TextSegment segment in segments) {
      TextStyle style = this.style ?? const TextStyle();

      // transform segment into text style parameters
      FontWeight? weight;
      if (segment.bold == true) {
        weight = FontWeight.bold;
      }

      FontStyle? fontStyle;
      if (segment.italic == true) {
        fontStyle = FontStyle.italic;
      }

      Color? color;
      if (colors[segment.color] != null) {
        color = colors[segment.color];
      }

      TextDecoration? decoration;
      TapGestureRecognizer? recognizer;
      if (segment.url != null) {
        color = urlColor;
        weight = FontWeight.bold;
        decoration = TextDecoration.underline;
        recognizer = TapGestureRecognizer()
          ..onTap = () => launchUrl?.call(segment.url!);
      }

      style = style.copyWith(
        color: color,
        fontStyle: fontStyle,
        fontWeight: weight,
        decoration: decoration,
      );
      result.add(
        TextSpan(
          text: segment.text,
          style: style,
          recognizer: recognizer,
        ),
      );
    }

    return result;
  }
}
