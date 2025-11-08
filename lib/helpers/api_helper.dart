import 'package:master_utility/master_utility.dart';

class ApiHelper {
  ApiHelper._();

  static final instance = ApiHelper._();

  final _apiService = APIService();

  Future<APIResponse<dynamic>> _getResponse(
    APIRequest request,
    bool isAuthorization, {
    dynamic Function(dynamic data)? apiResponse,
  }) async {
    final response = await _apiService.getApiResponse(request, apiResponse: apiResponse);
    return response;
  }

  Future<APIResponse<dynamic>> get({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.GET,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
      mixPanelEventModel: MixPanelEventModel(
        successData: {'successMessage': 'GET API Success', 'url': url},
        errorData: {'errorMessage': 'GET API Error', 'url': url},
      ),
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    return result;
  }

  Future<APIResponse<dynamic>> post({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
    bool needToNavigate = true,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.POST,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
      mixPanelEventModel: MixPanelEventModel(
        successData: {'successMessage': 'POST API Success', 'url': url},
        errorData: {'errorMessage': 'POST API Error', 'url': url},
      ),
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    return result;
  }

  Future<APIResponse<dynamic>> patch({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.PATCH,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
      mixPanelEventModel: MixPanelEventModel(
        successData: {'successMessage': 'PATCH API Success', 'url': url},
        errorData: {'errorMessage': 'PATCH API Error', 'url': url},
      ),
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    return result;
  }

  Future<APIResponse<dynamic>> put({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.PUT,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
      mixPanelEventModel: MixPanelEventModel(
        successData: {'successMessage': 'PUT API Success', 'url': url},
        errorData: {'errorMessage': 'PUT API Error', 'url': url},
      ),
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    return result;
  }

  Future<APIResponse<dynamic>> delete({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.DELETE,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
      mixPanelEventModel: MixPanelEventModel(
        successData: {'successMessage': 'DELETE API Success', 'url': url},
        errorData: {'errorMessage': 'DELETE API Error', 'url': url},
      ),
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    return result;
  }
}
