abstract class Filter<T> {
  String get name;
  bool allows(T object);
}
