String formatCurrency(int amount) {
  final str = amount.abs().toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    final posFromRight = str.length - i;
    buffer.write(str[i]);
    if (posFromRight > 1 && posFromRight % 3 == 1) {
      buffer.write(',');
    }
  }
  final sign = amount < 0 ? '-' : '';
  return '${sign}Rs ${buffer.toString()}';
}
