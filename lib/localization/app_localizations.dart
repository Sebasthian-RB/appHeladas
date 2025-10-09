class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static final Map<String, Map<String, String>> _localizedValues = {
    'es': {
      'title': 'Aplicación Agrícola',
      'language': 'Cambiar idioma',
      'crops': 'Cultivos',
      'advice': 'Consejos',
      'select_language': 'Selecciona tu idioma',
      'spanish': 'Español',
      'quechua': 'Quechua',
    },
    'qu': {
      'title': 'Sallqa Ruray Aplikasiyun',
      'language': 'Rimay allichay',
      'crops': 'Sallqakuna',
      'advice': 'Kawsay rimaykuna',
      'select_language': 'Rimay akllay',
      'spanish': 'Español',
      'quechua': 'Quechua',
    },
  };

  String getText(String key) {
    return _localizedValues[languageCode]?[key] ?? key;
  }
}
