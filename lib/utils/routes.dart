import 'package:field_services/screens/booking_detail/booking_detail_cubit.dart';
import 'package:field_services/screens/booking_detail/booking_detail_screen.dart';
import 'package:field_services/screens/change_password/change_password_cubit.dart';
import 'package:field_services/screens/change_password/change_password_screen.dart';
import 'package:field_services/screens/home/home_cubit.dart';
import 'package:field_services/screens/home/home_screen.dart';
import 'package:field_services/screens/home/notification/notification_cubit.dart';
import 'package:field_services/screens/home/notification/notification_screen.dart';
import 'package:field_services/screens/login/login_cubit.dart';
import 'package:field_services/screens/login/login_screen.dart';
import 'package:field_services/screens/map/map_screen.dart';
import 'package:field_services/screens/register/register_cubit.dart';
import 'package:field_services/screens/register/register_screen.dart';
import 'package:field_services/screens/select_language/select_language_cubit.dart';
import 'package:field_services/screens/select_language/select_language_screen.dart';
import 'package:field_services/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splashScreen = '/';
  static const String mapScreen = '/map_screen';
  static const String loginScreen = '/login_screen';
  static const String selectLanguageScreen = '/select_language_screen';
  static const String homeScreen = '/home_screen';
  static const String bookingDetailScreen = '/booking_detail_screen';
  static const String notificationScreen = '/notification_screen';
  static const String changePasswordScreen = '/change_password_screen';
  static const String registerScreen = '/register_screen';
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case loginScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      case selectLanguageScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => SelectLanguageCubit(),
            child: const SelectLanguageScreen(),
          ),
        );
      case homeScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => HomeCubit(),
            child: const HomeScreen(),
          ),
        );
      case mapScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const MapScreen(),
        );
        case bookingDetailScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => BookingDetailCubit(),
            child: const BookingDetailScreen(),
          ),
        );
        case notificationScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => NotificationCubit(),
            child: const NotificationScreen(),
          ),
        );
        case changePasswordScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => ChangePasswordCubit(),
            child: const ChangePasswordScreen(),
          ),
        );
        case registerScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (ctx) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );
      default:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
