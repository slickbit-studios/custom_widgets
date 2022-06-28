import 'package:custom_widgets/pop/prevent_pop.dart';
import 'package:flutter/material.dart';

bool _instanceOpen = false;

Future<T> loadWrap<T>({
  required BuildContext context,
  required Future<T> Function() work,
}) async {
  // Only one load dialog at a time is allowed to be opened, otherwise
  // results cannot be handled properly
  assert(!_instanceOpen);

  _instanceOpen = true;
  var result = await showDialog(
    context: context,
    builder: (context) => _Load(work: work),
    barrierDismissible: false,
  );
  _instanceOpen = false;

  if (result is _ExceptionWrapper) {
    throw result.exception;
  } else if (result is T) {
    return result;
  } else {
    throw LoadException(result.runtimeType, T);
  }
}

class LoadException {
  final Type type;
  final Type expectedType;

  LoadException(this.type, this.expectedType);

  @override
  String toString() {
    return 'Dialog returned invalid type $type. Expected $expectedType';
  }
}

class _ExceptionWrapper {
  final dynamic exception;

  _ExceptionWrapper(this.exception);
}

class _Load extends StatefulWidget {
  final Future Function() work;

  const _Load({Key? key, required this.work}) : super(key: key);

  @override
  State<_Load> createState() => _LoadState();
}

class _LoadState extends State<_Load> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var nav = Navigator.of(context);

      try {
        var result = await widget.work();
        nav.pop(result);
      } catch (err) {
        nav.pop(_ExceptionWrapper(err));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PreventPop(child: Center(child: CircularProgressIndicator()));
  }
}
