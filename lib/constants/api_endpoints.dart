class APIEndpoints {
  const APIEndpoints._();

  //* BASEURL : ideally we should use AppEnv.baseUrl but for now we are using a static url
  // static String get baseUrl => AppEnv.baseUrl;

  //* BASEURL
  static String get baseUrl => 'https://staging.chamberofsecrets.8club.co/v1';

  //* GET Experience List
  static String get getExperienceList => '$baseUrl/experiences?active=true';
}
