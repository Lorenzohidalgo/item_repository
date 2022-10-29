class ItemRepositoryException implements Exception {
  final String message;
  final String errorCode;

  const ItemRepositoryException({
    required this.message,
    required this.errorCode,
  });
}

/// Exception returned when no item was found
/// and the user does not accept a nullable result
const itemNotFound = ItemRepositoryException(
  errorCode: 'ItemNotFound',
  message:
      'The item could not be found, make sure you add the item to the map before fetching it',
);

/// Exception returned when `fetchItemFunction` was not set
/// and the user tries to call a function that requires `fetchItemFunction`.
const fetchFunctionNotSet = ItemRepositoryException(
  errorCode: 'FetchFunctionNotSet',
  message:
      'The current `ItemRepository` was initialized without setting the variable `fetchItemFunction`',
);

/// Exception returned when calling `fetchItemFunction` fails.
const fetchFunctionError = ItemRepositoryException(
  errorCode: 'FetchFunctionError',
  message: 'An Exception was returned while calling `fetchItemFunction`.',
);
