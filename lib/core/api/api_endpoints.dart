class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://koren-api.onrender.com/api/v1',
  );

  static const products = '/products';
  static const featured = '/products/featured';
  static const categories = '/categories';
  static const farmers = '/farmers';

  static const auth = '/auth';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const refresh = '/auth/refresh';
}
