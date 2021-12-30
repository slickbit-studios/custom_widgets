abstract class Sort<T> {
  bool ascending;

  Sort({this.ascending = true});

  int compareTo(T first, T second);

  bool equals(T first, T second) => compareTo(first, second) == 0;
  bool isSmaller(T first, T second) =>
      (compareTo(first, second) < 0 && ascending) ||
      (compareTo(first, second) > 0 && !ascending);
  bool isGreater(T first, T second) =>
      (compareTo(first, second) > 0 && ascending) ||
      (compareTo(first, second) < 0 && !ascending);

  void invert() => ascending = !ascending;
}
