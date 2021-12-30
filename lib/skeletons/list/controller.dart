import 'dart:async';

import 'package:custom_widgets/skeletons/list/sort.dart';

import 'filter.dart';

class ListStreamController<T> {
  final StreamController<List<T>> _controller;
  List<T>? _objects;
  List<Filter<T>> _filters;
  List<Sort<T>> _sorts;

  final Future<List<T>> Function() _reloadFunction;

  ListStreamController({
    required Future<List<T>> Function() reloadFunction,
    List<Filter<T>> filters = const [],
    List<Sort<T>> sorts = const [],
  })  : _controller = StreamController(),
        _reloadFunction = reloadFunction,
        _filters = filters,
        _sorts = sorts {
    reload();
  }

  StreamSink<List<T>> get sink => _controller.sink;

  Stream<List<T>> get stream => _controller.stream;

  set filters(List<Filter<T>> filters) {
    _filters = filters;
    _broadcast();
  }

  set sorts(List<Sort<T>> sorts) {
    _sorts = sorts;
    _broadcast();
  }

  /*
    Compares elements with == function and replaces an equal element with the
    new one or just adds if no equal element exists
   */
  void addOrReplace(T object) {
    if (_objects == null) {
      _objects = [object];
    } else {
      int index = _objects!.indexOf(object);
      if (index != -1) {
        _objects!.removeAt(index);
      }
      _objects!.add(object);
    }
    _broadcast();
  }

  void remove(T object) {
    if (_objects != null) {
      _objects!.remove(object);
      _controller.add(_organizeList(_objects!));
    }
  }

  Future<void> reload() async {
    await _reloadFunction().then(replace).catchError(_onError);
  }

  void replace(List<T> objects) {
    _objects = objects;
    _broadcast();
  }

  void _onError(var error) {
    _controller.addError(error);
  }

  bool _filter(T element) {
    try {
      _filters.firstWhere((filter) => !filter.allows(element));
    } catch (_) {
      return true; // all filters allow the element
    }
    return false;
  }

  List<T> _organizeList(List<T> list) {
    // filter and sort
    List<T> filtered = _filterList(list);
    return _sortList(filtered);
  }

  List<T> _filterList(List<T> list) {
    List<T> filtered = [];

    // apply filters
    for (var element in list) {
      if (_filter(element)) {
        filtered.add(element);
      }
    }

    return filtered;
  }

  List<T> _sortList(List<T> list) {
    List<T> sortedList = List.of(list);
    for (int i = sortedList.length - 1; i > 0; i--) {
      for (int j = 0; j < i; j++) {
        for (var s in _sorts) {
          if (s.isSmaller(sortedList[j], sortedList[j + 1])) {
            break; // next sorts can be skipped
          } else if (s.isGreater(sortedList[j], sortedList[j + 1])) {
            // swap positions
            T save = sortedList[j];
            sortedList[j] = sortedList[j + 1];
            sortedList[j + 1] = save;
            break; // next sorts can be skipped
          }
        }
      }
    }

    return List.unmodifiable(sortedList);
  }

  void _broadcast() {
    _controller.add(_organizeList(_objects!));
  }
}
