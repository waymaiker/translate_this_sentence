class Word {
  final String textContent;
  final int id;
  bool isActivated;

  Word({
    required this.textContent,
    required this.id,
    this.isActivated = true
  });
}