class ApiErrors {
  static const String noInternet = 'No internet connection';
  static const String timeout = 'Connection timeout';
  static const String serverError = 'Server error';
  static const String unknownError = 'Unknown error';
  static const String unauthorized = 'Unauthorized';
  static const String badRequest = 'Bad request';
  static const String notFound = 'Not found';
  static const String forbidden = 'Forbidden';
  static const String internalServerError = 'Internal server error';
  static const String serviceUnavailable = 'Service unavailable';
  static const String gatewayTimeout = 'Gateway timeout';
  static const String conflict = 'Conflict';
  static const String tooManyRequests = 'Too many requests';
  static const String notImplemented = 'Not implemented';
  static const String badGateway = 'Bad gateway';
  static const String unavailableForLegalReasons =
      'Unavailable for legal reasons';
  static const String unknown = 'Unknown';
}

class ApiConstants {
  // Base URL
  static const String baseUrl = "http://192.168.1.59:8000/api";

  // Auth Endpoints
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh-token";
  static const String userProfile = "/auth/user-profile";

  // User Endpoints
  static const String profile = "/user/profile";
  static const String updateProfile = "/user/update";
  static const String changePassword = "/user/change-password";

  // Scan Endpoints
  static const String uploadScan = "/scan/upload";
  static const String getScanHistory = "/scan/history";
  static const String getScanDetails = "/scan/details";

  // API Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // API Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // API Status Codes
  static const int success = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
}
