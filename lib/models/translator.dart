enum LanguageEnum { vi, en }

class Translator {
  int? id;
  String originalWord;
  String translatorWord;
  String originalLang;
  String translatorLang;
  Translator(
      {required this.originalWord,
      required this.translatorWord,
      this.id,
      required this.originalLang,
      required this.translatorLang});

  factory Translator.fromJson(Map<String, dynamic> map) {
    return Translator(
        originalWord: map['originalWord'] ?? "",
        translatorWord: map['translatorWord'] ?? "",
        id: map['id'] ?? "",
        originalLang: map['originalLang'] ?? "",
        translatorLang: map['translatorLang'] ?? "");
  }
}
