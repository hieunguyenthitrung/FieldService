import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    #if PROD
      GMSServices.provideAPIKey("AIzaSyCzJXiAMtmd9EfTSMXt_99iJ5ut9Lg8Qis")
    #else
      GMSServices.provideAPIKey("AIzaSyCzJXiAMtmd9EfTSMXt_99iJ5ut9Lg8Qis")
    #endif
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
