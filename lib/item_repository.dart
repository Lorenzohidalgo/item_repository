library item_repository;

import 'package:item_repository/repo_exceptions.dart';

class ItemRepository<T extends Object> {
  /// Private `Map<String, T>` map
  /// Used to cache the items.
  ///
  /// The current map can be set using `set setMap(Map<String, T> map)`
  /// The current map can be fetched using `Map<String, T> get itemMap`
  Map<String, T> _itemMap = <String, T>{};

  /// Nullable function.
  ///
  /// Used in `Future<T> fetchItem(String key)` or
  /// `Future<T?> fetchNullableItem(String key)`
  /// to download the item if not currently present.
  final Future<T?> Function(String key)? fetchItemFunction;

  ItemRepository({
    this.fetchItemFunction,
  });

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

  /// Returns the `Future<T> item`.
  ///
  /// If no item has been stored under the provided key,
  /// the item will be fetched using `Future<T?> Function(String key)? fetchItemFunction`.
  ///
  /// If `Future<T?> Function(String key)? fetchItemFunction` was not set
  /// when initializing the repository a `ItemRepositoryException` is thrown.
  ///
  /// If no item was found and fetching the item returned a null value,
  /// a `ItemRepositoryException` is thrown.
  Future<T> fetchItem(String key) async {
    assert(fetchItemFunction != null, fetchFunctionNotSet);
    try {
      T? item = getNullableItem(key);

      if (item == null) {
        item = await fetchItemFunction!(key);

        if (item == null) throw itemNotFound;

        putItem(key: key, item: item);
      }

      return item;
    } catch (e) {
      if (e is ItemRepositoryException) rethrow;
      throw fetchFunctionError;
    }
  }

  /// Returns the `T? item`.
  ///
  /// If no item has been stored under the provided key, a null value is returned.
  T? getNullableItem(String key) => _itemMap[key];

  /// Returns the `Future<T> item`.
  ///
  /// If no item has been stored under the provided key,
  /// the item will be fetched using `Future<T?> Function(String key)? fetchItemFunction`.
  ///
  /// If `Future<T?> Function(String key)? fetchItemFunction` was not set
  /// when initializing the repository a `ItemRepositoryException` is thrown.
  Future<T?> fetchNullableItem(String key) async {
    assert(fetchItemFunction != null, fetchFunctionNotSet);
    try {
      T? item = getNullableItem(key);

      if (item == null) {
        item = await fetchItemFunction!(key);

        if (item != null) {
          putItem(key: key, item: item);
        }
      }

      return item;
    } catch (_) {
      throw fetchFunctionError;
    }
  }

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
