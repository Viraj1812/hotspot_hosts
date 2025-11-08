import 'package:dartz/dartz.dart';
import 'package:hotspot_hosts/constants/app_strings.dart';
import 'package:hotspot_hosts/constants/type_defs.dart';
import 'package:hotspot_hosts/features/common/models/failure_model.dart';
import 'package:master_utility/master_utility.dart';

class AppUtils {
  AppUtils._();

  static FutureEither<T> handleApiResponse<T>(APIResponse<dynamic> response, T Function(dynamic) mapper) async {
    if (response.hasError || response.data == null) {
      LogHelper.logError(response.message);
      return left(Failure(message: response.message ?? AppStrings.somethingWentWrong, statusCode: response.statusCode));
    }

    try {
      return right(mapper(response.data));
    } catch (e) {
      LogHelper.logError('Failed to map response data: $e');
      return left(Failure(message: AppStrings.somethingWentWrong));
    }
  }
}
