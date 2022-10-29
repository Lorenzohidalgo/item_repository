import 'package:flutter_test/flutter_test.dart';

import 'package:item_repository/item_repository.dart';

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
}
