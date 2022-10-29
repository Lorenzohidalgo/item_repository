library item_repository;

import 'package:item_repository/repo_exceptions.dart';

class ItemRepository<T extends Object> {
  /// Private `Map<String, T>` map
  /// Used to cache the items.
  ///
  /// The current map can be set using `set setMap(Map<String, T> map)`
  /// The current map can be fetched using `Map<String, T> get itemMap`
  Map<String, T> _itemMap = <String, T>{};

  /// Returns the current `Map<String, T>`
  ///
  /// The current map can be set using `set setMap(Map<String, T> map)`
  Map<String, T> get itemMap => _itemMap;

  /// Replaces the current `Map<String, T>` with the provided one
  ///
  /// The current map can be fetched using `Map<String, T> get itemMap`
  set setMap(Map<String, T> map) => _itemMap = map;

  /// Returns the `T item`.
  ///
  /// If no item has been stored under the provided key, a `ItemRepositoryException` is thrown.
  T getItem(String key) {
    final _item = _itemMap[key];

    if (_item == null) throw itemNotFound;

    return _item;
  }

  /// Returns the `T? item`.
  ///
  /// If no item has been stored under the provided key, a null value is returned.
  T? getNullableItem(String key) => _itemMap[key];

  /// Sets or updates an item
  ///
  /// `String key` representing the key used to identify the provided item
  ///
  /// `T item` provided item to be stored
  ///
  /// If no item under the current key exists, a new one will be added. If an item already exists with this key, it will be replaced by the new item.
  void putItem({
    required String key,
    required T item,
  }) =>
      _itemMap[key] = item;

  /// Removes an item
  ///
  /// `String key` representing the key used to identify the item to be removed
  ///
  /// If no item under the current key exists, nothing will happen. If an item exists with this key, it will be removed.
  void removeItem(String key) => _itemMap.remove(key);
}
