import 'package:shortnews/view/uitl/appimage.dart';

class LanguageModel {
  final String flag;
  final String name;
  final String languageCode;

  LanguageModel(
    this.flag,
    this.name,
    this.languageCode,
  );

  static List<LanguageModel> languageList() 
  {
    return <LanguageModel>[
     LanguageModel(" ", "English", 'en'), // english
      LanguageModel("", "Hindi", 'hi'), //swedish
    ];
  }
}
