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


      'maiz': 'Maíz',
      'papa': 'Papa',
      'olluco': 'Olluco',
      'mashua': 'Mashua',
      'quinua': 'Quinua',
      'habas': 'Habas',
      'alverjas': 'Alverjas',
      'oca': 'Oca',
      'cebada': 'Cebada',
      'trigo': 'Trigo',
      'zanahoria': 'Zanahoria',
      'col': 'Col',
      'lechuga': 'Lechuga',
      'apio': 'Apio',
      'nabo': 'Nabo',
      'crops_title': 'Condiciones y Recomendaciones de Cultivo',
      'crops_subtitle': 'Conoce cómo proteger y fortalecer tus cultivos',
      'crops_description': 'Explora los consejos según el tipo de cultivo para prevenir los efectos de las heladas.',
    },
    'qu': {
      'title': 'Sallqa Ruray Aplikasiyun',
      'language': 'Rimay allichay',
      'crops': 'Sallqakuna',
      'advice': 'Kawsay rimaykuna',
      'select_language': 'Rimay akllay',
      'spanish': 'Español',
      'quechua': 'Quechua',

      'maiz': 'Sara',
      'papa': 'Papa',
      'olluco': 'Olluqu',
      'mashua': 'Añu',
      'quinua': 'Kiwicha',
      'habas': 'Wawa',
      'alverjas': 'Arveja',
      'oca': 'Oqa',
      'cebada': 'Kaspa',
      'trigo': 'Trigu',
      'zanahoria': 'Zanahoria',
      'col': 'Kuli',
      'lechuga': 'Lechuga',
      'apio': 'Apiyu',
      'nabo': 'Nabu',
      'crops_title': 'Yurakunapa kamachiykuna',
      'crops_subtitle': 'Yurakunata sumaqta waqaychayta yachay',
      'crops_description': 'Heladawan manchakuyta ñawpaqta hark’aypaq yachachiykuna.',
    },
  };

  String getText(String key) {
    return _localizedValues[languageCode]?[key] ?? key;
  }
}
