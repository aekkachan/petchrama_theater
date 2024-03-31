import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';

class Utils {
  final BuildContext context;

  Utils(this.context);

  double getWidth() => MediaQuery.of(context).size.width;

  double getHeight() => MediaQuery.of(context).size.height;

  static Future<bool> checkInternetConnection() async => await InternetConnection().hasInternetAccess;

  static convertDate2String(DateTime dateTime, String format) => DateFormat(format).format(dateTime);
}
