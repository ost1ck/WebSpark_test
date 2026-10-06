class CalculationException implements Exception {
  const CalculationException(this.message);

  final String message;

  @override
  String toString() => message;
}
