enum Language { vie, eng }

class Translator {
  String primaryKey;
  Map<Language, String> originalText;
  Map<Language, String> translatorText;
  Translator(
      {required this.originalText,
      required this.translatorText,
      required this.primaryKey});
}
