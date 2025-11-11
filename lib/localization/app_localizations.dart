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


      // ===== Cultivos =====
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
      "temperature_avg": "Temperatura promedio",
      "description": "Descripción",
      "white_frost": "Helada Blanca",
      "black_frost": "Helada Negra",

      // Detalles de cada cultivo
      'maiz_temp': '18 °C – 27 °C',
      'maiz_desc': 'Prefiere suelos profundos, bien drenados y con buen contenido de materia orgánica. Evitar suelos muy fríos o encharcados. Requiere riego constante durante la floración.',
      'maiz_white': 'Cubrir con paja o plástico en crecimiento temprano y regar antes del amanecer.',
      'maiz_black': 'Activar aspersores para aumentar humedad ambiental.',

      'papa_temp': '14 °C – 18 °C',
      'papa_desc': 'Cultivo andino resistente, pero sensible a heladas fuertes, sobre todo en floración. Evitar heladas y exceso de humedad.',
      'papa_white': 'Aplicar riego ligero antes del amanecer y cubrir con mulch o paja.',
      'papa_black': 'Activar riego por aspersión continua para aumentar humedad y proteger el follaje.',

      'olluco_temp': '10 °C – 16 °C',
      'olluco_desc': 'Necesita humedad constante y exposición solar parcial. Se adapta a suelos franco-arenosos con buen drenaje.',
      'olluco_white': 'Cubrir el cultivo con hojas secas o paja.',
      'olluco_black': 'Aumentar la humedad mediante riego por aspersión y proteger con coberturas plásticas.',

      'mashua_temp': '8 °C – 15 °C',
      'mashua_desc': 'Se adapta bien a zonas altoandinas. Requiere humedad moderada y suelos fértiles, profundos y bien drenados.',
      'mashua_white': 'Cubrir con paja o malla térmica.',
      'mashua_black': 'Mantener riego por aspersión nocturno para reducir el impacto del frío seco.',

      'quinua_temp': '12 °C – 20 °C',
      'quinua_desc': 'Tolera heladas leves y sequía moderada. Prefiere suelos francos y ligeramente alcalinos.',
      'quinua_white': 'Aplicar riego antes del amanecer.',
      'quinua_black': 'Activar aspersores para conservar temperatura.',

      'habas_temp': '12 °C – 18 °C',
      'habas_desc': 'Se cultiva en climas templados y fríos. Requiere suelos profundos y buena humedad durante la floración.',
      'habas_white': 'Cubrir con plástico o manta térmica.',
      'habas_black': 'Usar riego por aspersión y barreras cortaviento.',

      'alverjas_temp': '10 °C – 20 °C',
      'alverjas_desc': 'Prefiere climas templados fríos y secos, suelos bien drenados y ricos en materia orgánica.',
      'alverjas_white': 'Cubrir con mulch o túneles bajos.',
      'alverjas_black': 'Activar riego nocturno para mantener humedad y evitar daños en flores.',

      'oca_temp': '8 °C – 15 °C',
      'oca_desc': 'Necesita suelos ligeros y húmedos. Tolera bien las lluvias, pero no el encharcamiento.',
      'oca_white': 'Cubrir con paja seca.',
      'oca_black': 'Activar aspersores si se prevé helada negra.',

      'cebada_temp': '10 °C – 20 °C',
      'cebada_desc': 'Ideal para zonas frías y secas. Soporta heladas ligeras. Suelos medianamente fértiles y bien drenados.',
      'cebada_white': 'Riego ligero previo al amanecer.',
      'cebada_black': 'Activar aspersores o usar humo agrícola.',

      'trigo_temp': '12 °C – 25 °C',
      'trigo_desc': 'Prefiere climas templados y secos. Evitar suelos salinos y encharcados.',
      'trigo_white': 'Mantener humedad en el suelo.',
      'trigo_black': 'Riego por aspersión.',

      'zanahoria_temp': '15 °C – 20 °C',
      'zanahoria_desc': 'Suelos sueltos, profundos y arenosos. Requiere riego moderado y constante.',
      'zanahoria_white': 'Cubrir con mulch o túneles.',
      'zanahoria_black': 'Riego por aspersión nocturno para conservar calor.',

      'col_temp': '13 °C – 20 °C',
      'col_desc': 'Crece bien en climas frescos. Necesita suelos ricos en nutrientes y buen riego.',
      'col_white': 'Cubrir con manta térmica.',
      'col_black': 'Activar aspersores para prevenir daño en hojas.',

      'lechuga_temp': '14 °C – 18 °C',
      'lechuga_desc': 'Prefiere climas templados y húmedos. Requiere riego frecuente y suelos fértiles.',
      'lechuga_white': 'Cubrir con plástico o manta.',
      'lechuga_black': 'Activar riego o cubrir con microtúneles.',

      'apio_temp': '15 °C – 21 °C',
      'apio_desc': 'Necesita abundante humedad, sombra parcial y suelos ricos en materia orgánica.',
      'apio_white': 'Cubrir con manta térmica o mulch.',
      'apio_black': 'Activar riego nocturno o humo controlado.',

      'nabo_temp': '10 °C – 18 °C',
      'nabo_desc': 'Se adapta a climas templados. Evitar suelos arcillosos y compactos.',
      'nabo_white': 'Cubrir con mulch o paja.',
      'nabo_black': 'Activar riego por aspersión para aumentar humedad ambiental.',
    },

    'qu': {
      'title': 'Sallqa Ruray Aplikasiyun',
      'language': 'Rimay allichay',
      'crops': 'Sallqakuna',
      'advice': 'Kawsay rimaykuna',
      'select_language': 'Rimay akllay',
      'spanish': 'Español',
      'quechua': 'Quechua',

      // ===== Cultivos =====
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
      "temperature_avg": "Ruphay tupuy chanin",
      "description": "Nirqay",
      "white_frost": "Rit'i Yurak",
      "black_frost": "Rit'i Yana",

      // Detalles traducidos
      'maiz_temp': '18 °C – 27 °C',
      'maiz_desc': 'Allin chakra, chaki k’uchusqa, allin yaku puriqmi munan. Mana chiri chakraqa.',
      'maiz_white': 'Ichuwan tapay, qhipaman rikhurichiy hina, punchawlla riega.',
      'maiz_black': 'Aspersorwan yaku waqaychayta ruray.',

      'papa_temp': '14 °C – 18 °C',
      'papa_desc': 'Andespi wiñaqmi, ichaqa qhari heladawan manam allinchu. Wayraqkunawan yaku aswan mana ch’allaychu.',
      'papa_white': 'P’unchayta qhipaman riega, ichuwan tapay.',
      'papa_black': 'Aspersorwan riega tuta p’unchawkunapi.',

      'olluco_temp': '10 °C – 16 °C',
      'olluco_desc': 'Yakuqa wiñay munan, inti rikhuy sasachakuy, allin chakra allpawan.',
      'olluco_white': 'Rapakunawan tapay.',
      'olluco_black': 'Aspersorwan yaku muchuyta ruray.',

      'mashua_temp': '8 °C – 15 °C',
      'mashua_desc': 'Sallqapi wiñaq, allin allpawanmi munan, chiriqa manam allinchu.',
      'mashua_white': 'Ichuwan tapay.',
      'mashua_black': 'Aspersorwan tuta riega.',

      'quinua_temp': '12 °C – 20 °C',
      'quinua_desc': 'Heladawan mana aswan manchakuy, chiri yuraq chakrakunapi allin wiñan.',
      'quinua_white': 'P’unchayman qhipa riega.',
      'quinua_black': 'Aspersorwan riega ruray.',

      'habas_temp': '12 °C – 18 °C',
      'habas_desc': 'Chiri yaku kaq llapan llaqtakunapi allin wiñan.',
      'habas_white': 'Manta térmicawan tapay.',
      'habas_black': 'Aspersorwan riega, wayra hark’a ruray.',

      'alverjas_temp': '10 °C – 20 °C',
      'alverjas_desc': 'Chiri yuraq chakrakunapi allin, yaku rikhuy mana aswan.',
      'alverjas_white': 'Mulchwan tapay.',
      'alverjas_black': 'Tuta riega ruray.',

      'oca_temp': '8 °C – 15 °C',
      'oca_desc': 'Allin chakra yakuwan, mana t’akya, mana ch’allay.',
      'oca_white': 'Ichuwan tapay.',
      'oca_black': 'Aspersorwan riega tuta p’unchaykunapi.',

      'cebada_temp': '10 °C – 20 °C',
      'cebada_desc': 'Chiri llaqtakunapi allin wiñan, mana aswan yuraqmi munan.',
      'cebada_white': 'P’unchayta riega llapaq.',
      'cebada_black': 'Aspersorwan ruray, hinaqa qhawan huk humo ruray.',

      'trigo_temp': '12 °C – 25 °C',
      'trigo_desc': 'Sumaq allpapi wiñaq, mana yaku muchuychu, mana salwan chakrachu.',
      'trigo_white': 'Yakuqa allin waqaychasqa kachun.',
      'trigo_black': 'Aspersorwan riega ruray.',

      'zanahoria_temp': '15 °C – 20 °C',
      'zanahoria_desc': 'Allpa suyu, ñawpaqta yaku munan.',
      'zanahoria_white': 'Mulchwan tapay.',
      'zanahoria_black': 'Aspersorwan riega tuta p’unchaykunapi.',

      'col_temp': '13 °C – 20 °C',
      'col_desc': 'Chiri suni llaqtakunapi allin wiñan, allin yaku munan.',
      'col_white': 'Manta térmicawan tapay.',
      'col_black': 'Aspersorwan riega ruray.',

      'lechuga_temp': '14 °C – 18 °C',
      'lechuga_desc': 'Templadopi allin, yaku munan, allin allpawan.',
      'lechuga_white': 'Plásticowan tapay.',
      'lechuga_black': 'Riega tuta hina o microtúnelwan tapay.',

      'apio_temp': '15 °C – 21 °C',
      'apio_desc': 'Aswan yaku munan, llumpay sombra, allin chakra allpawan.',
      'apio_white': 'Manta térmicawan tapay.',
      'apio_black': 'Tuta riega o humo ruray.',

      'nabo_temp': '10 °C – 18 °C',
      'nabo_desc': 'Templadopi allin wiñan, mana allpa rikhuychakuqchu.',
      'nabo_white': 'Mulchwan tapay.',
      'nabo_black': 'Aspersorwan riega ruray.'
    },
  };

  String getText(String key) {
    return _localizedValues[languageCode]?[key] ?? key;
  }
}
