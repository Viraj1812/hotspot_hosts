import 'package:dartz/dartz.dart';
import 'package:hotspot_hosts/constants/api_endpoints.dart';
import 'package:hotspot_hosts/constants/app_strings.dart';
import 'package:hotspot_hosts/constants/type_defs.dart';
import 'package:hotspot_hosts/features/common/models/failure_model.dart';
import 'package:hotspot_hosts/features/onboarding/models/experience_response_data_model.dart';
import 'package:hotspot_hosts/helpers/api_helper.dart';
import 'package:hotspot_hosts/helpers/app_utils.dart';
import 'package:master_utility/master_utility.dart';

abstract interface class IOnboardingRepository {
  FutureEither<List<Experiences>> getExperienceList();
}

class OnboardingRepository implements IOnboardingRepository {
  @override
  FutureEither<List<Experiences>> getExperienceList() async {
    try {
      final response = await ApiHelper.instance.get(
        url: APIEndpoints.getExperienceList,
        fromJson: (data) => ExperienceResponseDataModel.fromJson(data as Map<String, dynamic>? ?? {}),
        queryParams: {'active': 'true'},
        isAuthorization: false,
      );

      return AppUtils.handleApiResponse<List<Experiences>>(
        response,
        (data) => (data as ExperienceResponseDataModel).data?.experiences ?? [],
      );
    } catch (e) {
      LogHelper.logError('Failed to get experience list $e');
      return left(Failure(message: AppStrings.somethingWentWrong));
    }
  }
}
