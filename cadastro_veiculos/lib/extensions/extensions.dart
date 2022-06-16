extension StringExtension on String {
  int toInt({int vlrPadrao = 0}) {
    return int.tryParse(this) ?? vlrPadrao;
  }
}