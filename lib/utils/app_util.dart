import 'package:field_services/app_config/app_config.dart';

class AppUtil {
  static void logout() {}

  static String badgeCount(int count) {
    if (count == 0) {
      return '';
    }
    if (count < 100) {
      return count.toString();
    }

    return '99+';
  }

  static printLogDevOnly(String message) {
    if (AppConfig.instance.flavor == Flavor.production) {
      return;
    }

    // ignore: avoid_print
    print(message);
  }
}
