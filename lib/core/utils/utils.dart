// ignore_for_file: implementation_imports

import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:ndialog/ndialog.dart';
import 'package:ndvpn/core/utils/network_available.dart';
import 'package:ndvpn/ui/components/alert_detail.dart';

export 'preferences.dart';
export 'navigations.dart';

NetworkInfo networkInfo = NetworkInfo(Connectivity());

Future<bool> assetExists(String path) async {
  try {
    await rootBundle.load(path);
    return true;
  } catch (e) {
    return false;
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

extension CheckProForAd on AdWithoutView {
  void showIfNotPro(BuildContext context) {
    // if (!IAPProvider.watch(context).isPro) {
    instanceManager.showAdWithoutView(this);
    // }
  }
}

Future<bool> checkUpdate(BuildContext context) async {
  try {
    var info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      if (info.flexibleUpdateAllowed) {
        InAppUpdate.startFlexibleUpdate().then((value) {
          InAppUpdate.completeFlexibleUpdate();
        });
      }
      if (info.immediateUpdateAllowed) {
        InAppUpdate.performImmediateUpdate();
      }
      return true;
    }
  } catch (_) {}
  return false;
}

class AssetsPath {
  static const String imagepath = "assets/images/";
  static const String iconpath = "assets/icons/";
}

void alertBox(String message, bool exit, BuildContext context) {
  DialogBackground(
    dialog: AlertScreen(
      message: message,
      exit: exit,
    ),
    blur: 10,
    dismissable: false,
  ).show(context);
}
