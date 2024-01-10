import 'package:ndvpn/core/utils/constant.dart';

class PointsDetailsReq {
  static String sign = AppConstants.sign;
  static String salt = AppConstants.randomSalt.toString();
  static String packageName = AppConstants.packageName;
  final String methodName;

  PointsDetailsReq({required this.methodName});

  Map<String, dynamic> toJson() {
    return {
      'sign': sign,
      'salt': salt,
      'package_name': packageName,
      'method_name': methodName
    };
  }
}