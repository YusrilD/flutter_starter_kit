extension ListExtension<T> on List<T> {
  // Get random item from list
  T? get randomItem {
    if (isEmpty) return null;
    return this[DateTime.now().millisecondsSinceEpoch % length];
  }

  // Remove duplicates from list
  List<T> get removeDuplicates => toSet().toList();

  // Split list into chunks
  List<List<T>> chunk(int size) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  // Separate list into two lists based on condition
  Map<bool, List<T>> separate(bool Function(T element) condition) {
    final truthyList = <T>[];
    final falsyList = <T>[];

    forEach((element) {
      if (condition(element)) {
        truthyList.add(element);
      } else {
        falsyList.add(element);
      }
    });

    return {
      true: truthyList,
      false: falsyList,
    };
  }

  // Get all combinations of list elements
  List<List<T>> get combinations {
    List<List<T>> result = [[]];
    forEach((element) {
      final newCombinations = result.map((combo) => [...combo, element]).toList();
      result.addAll(newCombinations);
    });
    return result;
  }

  // Rotate list by offset
  List<T> rotate(int offset) {
    if (isEmpty) return this;
    final effectiveOffset = offset % length;
    return [...sublist(effectiveOffset), ...sublist(0, effectiveOffset)];
  }

  // Check if all elements satisfy condition
  bool all(bool Function(T element) test) => every(test);

  // Check if any element satisfies condition
  bool any(bool Function(T element) test) => where(test).isNotEmpty;

  // Count elements that satisfy condition
  int count(bool Function(T element) test) => where(test).length;

  // Get element at index or null if index out of bounds
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  // Sum numeric list
  num sum() {
    if (isEmpty) return 0;
    if (T is num) {
      return fold(0, (sum, item) => sum + (item as num));
    }
    throw Exception('List elements must be numeric');
  }

  // Average of numeric list
  double average() {
    if (isEmpty) return 0;
    return sum() / length;
  }

  // Shuffle list and return new instance
  List<T> get shuffled {
    final list = [...this];
    list.shuffle();
    return list;
  }

  // Group list elements by key
  Map<K, List<T>> groupBy<K>(K Function(T element) keyFunction) {
    final map = <K, List<T>>{};
    forEach((element) {
      final key = keyFunction(element);
      map.putIfAbsent(key, () => []).add(element);
    });
    return map;
  }
} 