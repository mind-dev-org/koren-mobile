class AppConfig {
  static const Environment env = Environment.aws;
  static const bool useMock = false;

  static String get baseUrl {
    switch (env) {
      case Environment.local:
        return 'http://10.0.2.2:8000/api/v1/';
      case Environment.render:
        return 'https://koren-api.onrender.com/api/v1/';
      case Environment.aws:
        return 'https://d2tmkbsw9vga7t.cloudfront.net/api/v1/';
    }
  }

  static const String imageBaseUrl = 'https://koren-api.onrender.com';
}

enum Environment {
  local,
  render,
  aws,
}
