import 'package:flutter_test/flutter_test.dart';

import 'package:item_repository/item_repository.dart';
import 'package:item_repository/repo_exceptions.dart';

import 'test_objects/user.dart';

void main() {
  group('Basic item repo functionality:', () {
    final ItemRepository<User> testRepo = ItemRepository<User>();

    test('Returns empty map after init', () {
      expect(testRepo.itemMap, {});
    });

    const User testUser = User(
      id: 'id',
      name: 'name',
      age: 5,
    );

    test('Test Put item', () {
      testRepo.putItem(
        key: 'key',
        item: testUser,
      );
      expect(testRepo.getItem('key'), testUser);
    });

    test('Test remove item', () {
      testRepo.removeItem('key');
      expect(testRepo.itemMap, {});
    });
  });

  group('Get functionality Exceptions:', () {
    final ItemRepository<User> testRepo = ItemRepository<User>();

    test('`getItem` throws Error on itemNotFound', () {
      try {
        testRepo.getItem('key');
      } on ItemRepositoryException catch (e) {
        expect(e.errorCode, itemNotFound.errorCode);
        return;
      } catch (e) {
        rethrow;
      }
    });

    test('`getNullableItem` throws no Error on itemNotFound', () {
      expect(
        testRepo.getNullableItem('key'),
        null,
      );
    });
  });

  group('Fetch functionality Exceptions:', () {
    final ItemRepository<User> nullfetchItemFunctiontestRepo =
        ItemRepository<User>();

    test(
        '`fetchItem` throws Assertion Error if `fetchItemFunction` has not been set',
        () {
      expect(
        nullfetchItemFunctiontestRepo.fetchItem('key'),
        throwsAssertionError,
      );
    });

    test(
        '`fetchNullableItem` throws Assertion Error if `fetchItemFunction` has not been set',
        () {
      expect(
        nullfetchItemFunctiontestRepo.fetchNullableItem('key'),
        throwsAssertionError,
      );
    });

    final ItemRepository<User> exceptionFetchItemFunctiontestRepo =
        ItemRepository<User>(
      fetchItemFunction: (key) async => throw Exception(),
    );

    test('`fetchItem` throws Error on `fetchItemFunction` exception', () async {
      try {
        await exceptionFetchItemFunctiontestRepo.fetchItem('key');
      } on ItemRepositoryException catch (e) {
        expect(e.errorCode, fetchFunctionError.errorCode);
        return;
      } catch (e) {
        rethrow;
      }
    });

    test('`fetchNullableItem` throws Error on `fetchItemFunction` exception',
        () async {
      try {
        await exceptionFetchItemFunctiontestRepo.fetchNullableItem('key');
      } on ItemRepositoryException catch (e) {
        expect(e.errorCode, fetchFunctionError.errorCode);
        return;
      } catch (e) {
        rethrow;
      }
    });

    final ItemRepository<User> nullItemFetchItemFunctiontestRepo =
        ItemRepository<User>(
      fetchItemFunction: (key) async => null,
    );

    test('`fetchItem` throws Error on itemNotFound', () async {
      try {
        await nullItemFetchItemFunctiontestRepo.fetchItem('key');
      } on ItemRepositoryException catch (e) {
        expect(e.errorCode, itemNotFound.errorCode);
        return;
      } catch (e) {
        rethrow;
      }
    });

    test('`fetchNullableItem` throws no Error on itemNotFound', () async {
      expect(
        await nullItemFetchItemFunctiontestRepo.fetchNullableItem('key'),
        null,
      );
    });
  });
}
