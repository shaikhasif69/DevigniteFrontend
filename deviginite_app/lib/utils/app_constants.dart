import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:get/get.dart';

class AppConstants {
  static const String appName = 'OFFOZON';
  static const double appVersion = 2.5;

  static const String fontFamily = 'Roboto';

  static const Color themeColor = Color(0xffD91106);
  static const String IP = "http://192.168.6.186:4000";
  static String eventAttachments = "http://${IP}/images/";
  // colours
  static const Color tPrimaryColor =
      Color.fromARGB(255, 201, 126, 126); // Replace 0xFF with the opacity value
  static const Color tAccentColor = Color(0xFFF15A59);
  static const Color extraColor = Color(0xFFB5C0D0);
  static const Color extraColor2 = Color(0xFFFFF7F1);
  static const Color myColor = Color(0xFFFFF2F2);
  static const Color greenColor = Color(0xFFDCFFB7);
  static const Color blueColor = Color(0xFF40DFEF);
  static const Color something = Color(0xFFFF6363);
  static const Color darkBlue = Color(0xFF1D2B53);

  /// Shared Key
  static const String theme = '6ammart_theme';
  static const String token = '6ammart_token';
  static const String countryCode = '6ammart_country_code';
  static const String languageCode = '6ammart_language_code';
  static const String cartList = '6ammart_cart_list';
  static const String userPassword = '6ammart_user_password';
  static const String userAddress = '6ammart_user_address';
  static const String userNumber = '6ammart_user_number';
  static const String userCountryCode = '6ammart_user_country_code';
  static const String notification = '6ammart_notification';
  static const String searchHistory = '6ammart_search_history';
  static const String intro = '6ammart_intro';
  static const String notificationCount = '6ammart_notification_count';
  static const String dmTipIndex = '6ammart_dm_tip_index';
  static const String earnPoint = '6ammart_earn_point';
  static const String acceptCookies = '6ammart_accept_cookies';
  static const String suggestedLocation = '6ammart_suggested_location';
  static const String walletAccessToken = '6ammart_wallet_access_token';
  static const String guestId = '6ammart_guest_id';
  static const String guestNumber = '6ammart_guest_number';

  static const String topic = 'all_zone_customer';
  static const String zoneId = 'zoneId';
  static const String operationAreaId = 'operationAreaId';
  static const String moduleId = 'moduleId';
  static const String cacheModuleId = 'cacheModuleId';
  static const String localizationKey = 'X-localization';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String cookiesManagement = 'cookies_management';
}
