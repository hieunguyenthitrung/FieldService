
import 'package:field_services/app_config/app_config.dart';

class AppUtil {
  static void logout() {

  }

  static printLogDevOnly(String message) {
    if (AppConfig.instance.flavor == Flavor.production) {
      return;
    }

    // ignore: avoid_print
    print(message);
  }
}
