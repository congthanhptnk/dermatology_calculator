import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final Translations _wallet = Translations.byText('en_us') +
      {
        'en_us': 'Evaluate',
        'vi_vn': 'Danh Gia',
      } +
      {
        'en_us': 'Dental Machine Learning Demo',
        'vi_vn': 'Testing',
      } +
      {
        'en_us': "Spin to win more",
        'vi_vn': "Spin to win more",
      };

  static final Translations _translations = _wallet;

  String get i18n => localize(this, _translations);

  String plural(int number) => localizePlural(number, this, _translations);

  String fill(List<Object> params) => localizeFill(this, params);
}
