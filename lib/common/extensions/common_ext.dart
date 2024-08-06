extension NullSafeBlock<T> on T? {
  void ifNotNull(Function(T it) runnable) {
    final instance = this;
    if (instance != null) {
      runnable(instance);
    }
  }
}

extension NullableString on String? {
  bool get isNullOrEmpty {
    return this == null || this == "";
  }

  bool get hasCharacter {
    return this != null && this != "";
  }
}

extension NullableList on List<dynamic>? {
  bool get hasItem {
    return this != null && this!.isNotEmpty;
  }
}

extension DateExt on DateTime {
  bool isSameDate(DateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }
}
