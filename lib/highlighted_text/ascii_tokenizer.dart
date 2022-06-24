// ignore: non_constant_identifier_names

// ignore: non_constant_identifier_names
final REGEX_FORMATTINGS = RegExp(r'((\[.+?\])#.+?#)|(\*.+?\*)|(\+.+?\+)');

// ignore: non_constant_identifier_names
final REGEX_BOLD = RegExp(r'^\*.+\*$');
// ignore: non_constant_identifier_names
final REGEX_ITALIC = RegExp(r'^\+.+\+$');
// ignore: non_constant_identifier_names
final REGEX_COLOR = RegExp(r'^\[.+\]#.+#$');
// ignore: non_constant_identifier_names
final REGEX_BRACES = RegExp(r'^\[.+?\]');

const String URL_PREFIX = 'url:';

class TextSegment {
  final String text;
  final bool? bold;
  final bool? italic;
  final String? url;
  final String? color;

  TextSegment(this.text, {this.bold, this.italic, this.url, this.color});
}

class AsciiTextTokenizer {
  List<TextSegment> parse(String text) {
    List<TextSegment> segments = [TextSegment(text)];
    bool finished = false;

    // repeat parsing until nothing could have been parsed anymore
    while (!finished) {
      finished = true;

      for (int i = 0; i < segments.length; i++) {
        List<TextSegment>? replacement = _parseSegment(segments[i]);
        if (replacement != null) {
          segments.removeAt(i);
          segments.insertAll(i, replacement);
          finished = false;
        }
      }
    }

    return segments;
  }

  ///
  /// @return list of TextSegments to replace the current segment with, or null if the result would be an identical TextSegment
  ///
  List<TextSegment>? _parseSegment(TextSegment segment) {
    List<TextSegment> result = [];
    bool touched = false;
    String text = segment.text;

    int position = 0;
    while (position < text.length) {
      // find first token
      RegExpMatch? match =
          REGEX_FORMATTINGS.firstMatch(text.substring(position));
      if (match == null) {
        // no more results
        result.add(TextSegment(text.substring(position)));
        position = text.length;
      } else if (match.start > 0) {
        // standard string
        result.add(
          TextSegment(text.substring(position, position + match.start)),
        );
        position += match.start;
        touched = true;
      } else {
        // string with formatting
        String token = match.group(0)!;
        result.add(_parseFormattedToken(
          token,
          initialColor: segment.color,
          initialBold: segment.bold,
          initialItalic: segment.italic,
        ));
        touched = true;
        position += match.end - match.start;
      }
    }

    if (touched) {
      return result;
    }

    return null;
  }

  TextSegment _parseFormattedToken(String token,
      {String? initialColor,
      String? initialUrl,
      bool? initialBold,
      bool? initialItalic}) {
    String? color = initialColor;
    String? url = initialUrl;
    bool? bold = initialBold;
    bool? italic = initialItalic;

    bool finished = false;
    while (!finished) {
      if (REGEX_BOLD.hasMatch(token)) {
        token = token.substring(1, token.length - 1);
        bold = true;
      } else if (REGEX_ITALIC.hasMatch(token)) {
        token = token.substring(1, token.length - 1);
        italic = true;
      } else if (REGEX_COLOR.hasMatch(token)) {
        String braces = REGEX_BRACES.firstMatch(token)!.group(0)!;
        String format = braces.substring(1, braces.length - 1);
        if (format.startsWith(URL_PREFIX)) {
          url = format.substring(URL_PREFIX.length);
        } else {
          color = format;
        }
        token = token.replaceAll(REGEX_BRACES, '');
        token = token.substring(1, token.length - 1);
      } else {
        finished = true;
      }
    }

    return TextSegment(
      token,
      bold: bold,
      italic: italic,
      color: color,
      url: url,
    );
  }
}
