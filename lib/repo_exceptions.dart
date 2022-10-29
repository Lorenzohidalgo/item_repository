class ItemRepositoryException implements Exception {
  final String message;
  final String errorCode;

  const ItemRepositoryException({
    required this.message,
    required this.errorCode,
  });
}

const itemNotFound = ItemRepositoryException(
  errorCode: 'ItemNotFound',
  message:
      'The item could not be found, make sure you add the item to the map before fetching it',
);
